class HomeController < ApplicationController
  def index
  	user_authenticate
    @backlogs = Backlog.order(created_at: :desc)
    @updates = Hop.order(created_at: :desc).limit(5)
    if !@current_user.nil? && @current_user.user_type == 'User'
      redirect_to client_dashboard_path
    end
  end

  def redirect_notification
    notif = Notification.find(params[:id])
    if notif.viewed == 1
      redirect_to notif.link
    else
      notif.viewed = 1
      notif.save
      redirect_to notif.link
    end
  end

  def approve
    user_authenticate
    @hop = Hop.find(params[:id])
    
    @hop.approved = true
    @hop.approved_user = @current_user.id
    if @hop.save
      if @hop.recursive
        stage = Stage.find(@hop.next_stage)
        stage.hops.create(:name => @hop.name, :recursive => false)
        redirect_to client_projects_path(@hop.stage.core.id)
        User.where(:user_type => 'superUser').each do |u|
          u.notifications.create(:description => @current_user.name+' aprovou um item', :icon => 'fa-check text-green', :link => '/stages/'+@hop.stage.id)
        end
        @current_user.backlogs.create(:description => 'Aprovou o item '+@hop.name)
      else
        redirect_to client_projects_path(@hop.stage.core.id)
      end
    else
      redirect_to client_projects_path(@hop.stage.core.id), alert: 'Nao foi possivel aprovar!'
    end
    # redirect_to client_projects_path(@hop.stage.core.id)
  end

  def client
    user_authenticate
    if !@current_user.nil? && @current_user.user_type != 'User'
      redirect_to root_path
    end
  end

  def client_projects
    user_authenticate
    @project = Core.find(params[:id]) rescue nil

    if @project.nil?
      redirect_to root_path, notice: 'Item não se encontra mais em nosso registro!'
    end
  end

  def new_comment
    @comment = Comment.new(:comment => params[:comment][:comment], :has_image => params[:comment][:has_image], :picture => params[:comment][:picture], :hop_id => params[:comment][:hop_id], :user_id => params[:comment][:user_id])

    if @comment.save
      render json: {:message => 'Comentario postado com sucesso'}, :status => 200
    else
      render json: {:message => 'Erro ao postar comentario, tente novamente mais tarde'}, :status => 500
    end
  end

  def login
  	if !session[:user_id].nil?
  		redirect_to root_path
  	end
  end

  def sign_out
    session[:user_id] = nil
    redirect_to login_path
  end

  def signin
  	@user = User.where(:login => params[:login][:login]).first

  	if !@user.nil? && @user.authenticate(params[:login][:password])
  		session[:user_id] = @user.id.to_s
  		redirect_to root_path
  	else
  		redirect_to login_path, alert: 'Usuário ou senha inválido'
  	end
  end

  def profile
    user_authenticate
    @user = User.find(session[:user_id])
  end

  def profile_user_update
    @user = User.find(params[:user][:id])
    @current_user = User.find(session[:user_id])
 
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.phone = params[:user][:phone]
    @user.rg = params[:user][:rg]
    @user.cpf = params[:user][:cpf]
    @user.login = params[:user][:login]

    if @user.save(validate: false)
      @current_user.backlogs.create(:description => 'Atualização do usuário ' + @user.name)
      redirect_to profile_path
    else
      redirect_to profile_path, alert: 'Erro ao atualizar usuário'
    end
  end

  def profile_pic_update
    @user = User.find(params[:user][:id])
    @current_user = User.find(session[:user_id])
 
    @user.picture = params[:user][:picture]

    if @user.save(validate: false)
      @current_user.backlogs.create(:description => 'Alteração da foto de perfil do ' + @user.name)
      redirect_to profile_path
    else
      redirect_to profile_path, alert: 'Erro ao atualizar usuário'
    end
  end

  def profile_password_update
    @user = User.find(params[:user][:id])
    @current_user = User.find(session[:user_id])

    if !@user.nil? && @user.authenticate(params[:user][:atual])
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]

      if @user.save(validate: false)
        @current_user.backlogs.create(:description => 'Mudança de senha do ' + @user.name)
        redirect_to profile_path
      else
        redirect_to profile_path, alert: 'Erro ao atualizar usuário'
      end
    else
      redirect_to profile_path, alert: 'Senha antiga incorreta!'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name,:email,:phone,:rg,:cpf,:password,:password_confirmation,:picture,:login,:user_type)
    end

end
