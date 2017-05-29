class StagesController < ApplicationController
  def index
    #
  end

  def create
    @stage = Stage.new(stage_params)

    if @stage.save
      redirect_to core_path(params[:stage][:core_id]), notice: 'Estágio criado com sucesso!'
    else
      redirect_to core_path(params[:stage][:core_id]), alert: 'Erro ao criar estágio!'
    end
  end

  def new
  end

  def edit
  end

  def show
    if session[:user_id].nil?
      redirect_to login_path, alert: 'Faça o login para continuar'
    else
        @current_user = User.find(session[:user_id])
        @stage = Stage.find(params[:id])
        @stages = @stage.core.stages
        @hop = Hop.new
    end
  end

  def update
  end

  def destroy
  end

  private
    def stage_params
      params.require(:stage).permit(:name, :core_id)
    end
end
