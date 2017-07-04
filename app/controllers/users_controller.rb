class UsersController < ApplicationController
	before_action :user_authenticate

	def index 
		  	@users = User.all
	end
	
	def new
		  	@user = User.new
		  	@users = User.all
		  	@customers = Customer.all
	end

	def edit
		  	@user = User.find(params[:id])
		  	@users = User.all
		  	@customers = Customer.all
	end

	def show
		  	@user = User.find(params[:id])
		  	@users = User.all
		  	SystemMailer.welcome_email(@user).deliver
	end
	
	def update
	    @user = User.find(params[:id])
	    
	 
	    if @user.update(user_params)
	      @current_user.backlogs.create(:description => 'Atualização do usuário ' + @user.name)
	      redirect_to users_path
	    else
	      @customers = Customer.all
	      render 'edit'
	    end
	  end
	  
	def create
		@user = User.new(user_params)
		
		if @user.save
			@current_user.backlogs.create(:description => 'Criação do usuário ' + @user.name)
			if(params[:user][:redirect] == 'clients')
				redirect_to customer_path(@user.customer)
			else
				redirect_to @user	
			end
		else
			@customers = Customer.all
			render 'new'
		end

	end

	def destroy
	    @user = User.find(params[:id])
	 	@current_user.backlogs.create(:description => 'Exclusão do usuário ' + @user.name)
	 	
	    @user.destroy

	    redirect_to users_path
	end

	private
		def user_params
			params.require(:user).permit(:name,:email,:phone,:rg,:cpf,:password,:password_confirmation,:picture,:login,:user_type,:customer_id)
		end

end
