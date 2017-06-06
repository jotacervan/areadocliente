class CustomersController < ApplicationController
  def index
  	if session[:user_id].nil?
  		redirect_to login_path, alert: 'Faça o login para continuar'
  	else
  	  	@current_user = User.find(session[:user_id])
  	  	@customers = Customer.all
  	end
  end

  def new
    if session[:user_id].nil?
      redirect_to login_path, alert: 'Faça o login para continuar'
    else
        @current_user = User.find(session[:user_id])
        @customer = Customer.new
    end
  end

  def show
    if session[:user_id].nil?
      redirect_to login_path, alert: 'Faça o login para continuar'
    else
        @user = User.new
        @current_user = User.find(session[:user_id])
        @customer = Customer.find(params[:id])
        @core = Core.new
    end
  end

  def edit
    if session[:user_id].nil?
      redirect_to login_path, alert: 'Faça o login para continuar'
    else
        @current_user = User.find(session[:user_id])
        @customer = Customer.find(params[:id])
    end
  end

  def create
    @customer = Customer.new(clients_params)
    @current_user = User.find(session[:user_id])

    if @customer.save
      @current_user.backlogs.create(:description => 'Criação do cliente ' + @customer.name)
      redirect_to @customer
    else
      render 'new'
    end
  end

  def update
    @customer = Customer.find(params[:id])
    @current_user = User.find(session[:user_id])

    if @customer.update(clients_params)
      @current_user.backlogs.create(:description => 'Atualização do cliente ' + @customer.name)
      redirect_to @customer
    else
      @current_user = User.find(session[:user_id])
      render 'edit'
    end
  end

  def destroy
      @customer = Customer.find(params[:id])
      @current_user = User.find(session[:user_id])
      @current_user.backlogs.create(:description => 'Exclusão do cliente ' + @customer.name)
    
      @customer.destroy

      redirect_to customers_path
  end 
  
  private 
    def clients_params
      params.require(:customer).permit(:name,:phone,:contract,:zip,:street,:cnpj,:number,:complement,:neighborhood,:city,:state,:country,:has_maintenance,:total_maintenance,:used_maintenance)
    end

end
