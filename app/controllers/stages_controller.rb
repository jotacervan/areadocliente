class StagesController < ApplicationController
  before_action :user_authenticate
  def index
    #
  end

  def create
    @stage = Stage.new(stage_params)

    if @stage.save
      @current_user.backlogs.create(:description => 'Criação do estágio ' + @stage.name)
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
        @stage = Stage.find(params[:id])
        @stages = @stage.core.stages
        @hop = Hop.new
  end

  def update
    @stage = Stage.find(params[:id])
    
    if @stage.update(stage_params)
      redirect_to core_path(@stage.core.id), notice: 'Estágio Editado com Sucesso'
    else
      redirect_to core_path(@stage.core.id), alert: 'Não foi possível editar o estágio'
    end
  end

  def destroy
    @stage = Stage.find(params[:id])
    @core = @stage.core.id
    @stage.destroy()
    redirect_to core_path(@core), notice: 'Stágio deletado com Sucesso'
  end

  private
    def stage_params
      params.require(:stage).permit(:name, :core_id)
    end
end
# Comentarios habilitar dentro do cliente