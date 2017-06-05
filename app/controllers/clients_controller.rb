class ClientsController < ApplicationController
  def index
  	if session[:user_id].nil?
  		redirect_to login_path, alert: 'Faça o login para continuar'
  	else
  	  	@current_user = User.find(session[:user_id])
  	  	@clients = Client.all
  	end
  end

  def new
    if session[:user_id].nil?
      redirect_to login_path, alert: 'Faça o login para continuar'
    else
        @current_user = User.find(session[:user_id])
        @client = Client.new
    end
  end

  def show
    if session[:user_id].nil?
      redirect_to login_path, alert: 'Faça o login para continuar'
    else
        @user = User.new
        @current_user = User.find(session[:user_id])
        @client = Client.find(params[:id])
        @core = Core.new
    end
  end

  def edit
    if session[:user_id].nil?
      redirect_to login_path, alert: 'Faça o login para continuar'
    else
        @current_user = User.find(session[:user_id])
        @client = Client.find(params[:id])
    end
  end

  def create
    @client = Client.new(clients_params)
    @current_user = User.find(session[:user_id])

    if @client.save
      @current_user.backlogs.create(:description => 'Criação do cliente ' + @client.name)
      redirect_to @client
    else
      render 'new'
    end
  end

  def update
    @client = Client.find(params[:id])
    @current_user = User.find(session[:user_id])

    if @client.update(clients_params)
      @current_user.backlogs.create(:description => 'Atualização do cliente ' + @client.name)
      redirect_to @client
    else
      @current_user = User.find(session[:user_id])
      render 'edit'
    end
  end

  def destroy
      @client = Client.find(params[:id])
      @current_user = User.find(session[:user_id])
      @current_user.backlogs.create(:description => 'Exclusão do cliente ' + @client.name)
    
      @client.destroy

      redirect_to clients_path
  end 
  
  private 
    def clients_params
      params.require(:client).permit(:name,:phone,:contract,:zip,:street,:cnpj,:number,:complement,:neighborhood,:city,:state,:country,:has_maintenance,:total_maintenance,:used_maintenance)
    end

end
