class CustomersController < ApplicationController
  before_action :user_authenticate

  def index
  	  	@current_user = User.find(session[:user_id])
  	  	@customers = Customer.all
  end

  def new
        @current_user = User.find(session[:user_id])
        @customer = Customer.new
  end

  def show
        @user = User.new
        @current_user = User.find(session[:user_id])
        @customer = Customer.find(params[:id])
        @core = Core.new
  end

  def edit
        @current_user = User.find(session[:user_id])
        @customer = Customer.find(params[:id])
  end

  def create
    @customer = Customer.new(clients_params)
    @current_user = User.find(session[:user_id])

    if @customer.save
      @current_user.backlogs.create(:description => 'Criação do cliente ' + @customer.fantasy_name)
      redirect_to @customer
    else
      render 'new'
    end
  end

  def update
    @customer = Customer.find(params[:id])
    @current_user = User.find(session[:user_id])

    if @customer.update(clients_params)
      @current_user.backlogs.create(:description => 'Atualização do cliente ' + @customer.fantasy_name)
      redirect_to @customer
    else
      @current_user = User.find(session[:user_id])
      render 'edit'
    end
  end

  def destroy
      @customer = Customer.find(params[:id])
      @current_user = User.find(session[:user_id])
      @current_user.backlogs.create(:description => 'Exclusão do cliente ' + @customer.fantasy_name)
    
      @customer.destroy

      redirect_to customers_path
  end 
  
  private 
    def clients_params
      params.require(:customer).permit(:name,:fantasy_name,:phone,:contract,:zip,:street,:cnpj,:number,:complement,:neighborhood,:city,:state,:country,:has_maintenance,:total_maintenance,:used_maintenance)
    end

end
