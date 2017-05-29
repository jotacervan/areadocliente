class HopsController < ApplicationController
  def index
  end

  def create

    if params[:hop][:recursive] == '1'
      if params[:hop][:next_stage] == 'não'
        redirect_to stage_path(params[:hop][:stage_id]), notice: 'Para ser recursivo você precisa escolhar o próximo estágio'
      else
        @hop = Hop.new(hop_params)

        if @hop.save
          redirect_to stage_path(params[:hop][:stage_id]), notice: 'Passo Cadastrado com Sucesso'
        else
          redirect_to stage_path(params[:hop][:stage_id]), notice: 'Erro ao Cadastrar Passo'
        end
      end
    else
      
      @hop = Hop.new(hop_params)

      if @hop.save
        redirect_to stage_path(params[:hop][:stage_id]), notice: 'Passo Cadastrado com Sucesso'
      else
        redirect_to stage_path(params[:hop][:stage_id]), notice: 'Erro ao Cadastrar Passo'
      end

    end

  end

  def new
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
    hop = Hop.find(params[:id])
    stage = hop.stage.id
    hop.destroy()
    redirect_to stage_path(stage)
  end

  private
    def hop_params
      params.require(:hop).permit(:name,:status,:recursive,:next_stage,:stage_id)
    end
end
