class HomeController < ApplicationController
  def index
  	if session[:user_id].nil?
  		redirect_to login_path, alert: 'Faça o login para continuar'
  	end
  	@current_user = User.find(session[:user_id])
  	@backlogs = Backlog.order(created_at: :desc)
  end

  def login
  	if !session[:user_id].nil?
  		redirect_to root_path
  	end
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
    if session[:user_id].nil?
      redirect_to login_path, alert: 'Faça o login para continuar'
    end
    @current_user = User.find(session[:user_id])
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
