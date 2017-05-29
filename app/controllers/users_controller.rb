class UsersController < ApplicationController

	def index 
		if session[:user_id].nil?
  			redirect_to login_path, alert: 'Faça o login para continuar'
	  	else
		  	@current_user = User.find(session[:user_id])
		  	@users = User.all
	  	end
	end

	def new
		if session[:user_id].nil?
  			redirect_to login_path, alert: 'Faça o login para continuar'
	  	else
		  	@current_user = User.find(session[:user_id])
		  	@user = User.new
		  	@users = User.all
		  	@clients = Client.all
	  	end
	end

	def edit
		if session[:user_id].nil?
  		redirect_to login_path, alert: 'Faça o login para continuar'
	  	else
		  	@user = User.find(params[:id])
		  	@current_user = User.find(session[:user_id])
		  	@users = User.all
		  	@clients = Client.all
	  	end
	end

	def show
		if session[:user_id].nil?
  		redirect_to login_path, alert: 'Faça o login para continuar'
	  	else
		  	@user = User.find(params[:id])
		  	@current_user = User.find(session[:user_id])
		  	@users = User.all
	  	end
	end
	
	def update
	    @user = User.find(params[:id])
	    @current_user = User.find(session[:user_id])
	 
	    if @user.update(user_params)
	      @current_user.backlogs.create(:description => 'Atualização do usuário ' + @user.name)
	      redirect_to users_path
	    else
	      @clients = Client.all
	      render 'edit'
	    end
	  end
	  
	def create
		
		@user = User.new(user_params)

		if @user.save
			@current_user = User.find(session[:user_id])
			@current_user.backlogs.create(:description => 'Criação do usuário ' + @user.name)
			if(params[:user][:redirect] == 'clients')
				redirect_to client_path(@user.client)
			else
				redirect_to @user	
			end
		else
			@clients = Client.all
			render 'new'
		end

		
	end

	def destroy
	    @user = User.find(params[:id])
	    @current_user = User.find(session[:user_id])
	 	@current_user.backlogs.create(:description => 'Exclusão do usuário ' + @user.name)
	 	
	    @user.destroy

	    redirect_to users_path
	end

	private
		def user_params
			params.require(:user).permit(:name,:email,:phone,:rg,:cpf,:password,:password_confirmation,:picture,:login,:user_type,:client_id)
		end

end
