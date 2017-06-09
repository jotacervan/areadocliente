class CoresController < ApplicationController
  def index
    render json: 'Cores'
  end

  def new
    render json: 'new'
  end
  
  def show
    if session[:user_id].nil?
      redirect_to login_path, alert: 'Faça o login para continuar'
    else
        @current_user = User.find(session[:user_id])
        @core = Core.find(params[:id])
        @stage = Stage.new
    end
  end

  def edit
    render json: 'edit'
  end

  def create
    @core = Core.new(cores_params)
    
    if @core.save
      @current_user = User.find(session[:user_id])
      @current_user.backlogs.create(:description => 'Criação do projeto ' + @core.name)

      redirect_to @core
    else
      redirect_to customers_path(params[:core][:customer_id]), alert: 'Não foi possível criar projeto'
    end
  end

  def update
    @core = Core.find(params[:id])
    
    if @core.update(cores_params)
      redirect_to customer_path(params[:core][:customer_id]), notice: 'Projeto Editado com Sucesso'
    else
      redirect_to customer_path(params[:core][:customer_id]), alert: 'Não foi possível editar o projeto'
    end
  end

  def destroy
    @core = Core.find(params[:id])
    @current_user = User.find(session[:user_id])
    @current_user.backlogs.create(:description => 'Exclusão do projeto ' + @core.name)
  
    @core.destroy

    redirect_to customers_path
  end

  private
    def cores_params
      params.require(:core).permit(:name,:description,:customer_id)
    end
end
