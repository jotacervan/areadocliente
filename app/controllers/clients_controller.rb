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
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end


end
