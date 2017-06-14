class HopsController < ApplicationController
  before_action :user_authenticate

  def index
  end

  def create
    if params[:hop][:recursive] == '1'
      if params[:hop][:next_stage] == 'não'
        redirect_to stage_path(params[:hop][:stage_id]), notice: 'Para ser recursivo você precisa escolhar o próximo estágio'
      else
        @hop = Hop.new(hop_params)

        if @hop.save
          @current_user.backlogs.create(:description => 'Criação do item ' + @hop.name)
          redirect_to stage_path(params[:hop][:stage_id]), notice: 'Passo Cadastrado com Sucesso'
        else
          redirect_to stage_path(params[:hop][:stage_id]), notice: 'Erro ao Cadastrar Passo'
        end
      end
    else
      
      @hop = Hop.new(hop_params)

      if @hop.save
        @current_user.backlogs.create(:description => 'Criação do item ' + @hop.name)
        redirect_to stage_path(params[:hop][:stage_id]), notice: 'Passo Cadastrado com Sucesso'
      else
        redirect_to stage_path(params[:hop][:stage_id]), notice: 'Erro ao Cadastrar Passo'
      end

    end

  end

  def solicitation
    if params[:hop][:recursive] == '1'
      if params[:hop][:next_stage] == 'não'
        redirect_to stage_path(params[:hop][:stage_id]), notice: 'Para ser recursivo você precisa escolhar o próximo estágio'
      else
        @hop = Hop.new(hop_params)

        if @hop.save
          @current_user.backlogs.create(:description => 'Nova Solicitação: ' + @hop.name)
          redirect_to client_projects_path(@hop.stage.core), notice: 'Solicitação enviada com Sucesso'
        else
          redirect_to client_projects_path(@hop.stage.core), notice: 'Erro ao enviar solicitação'
        end
      end
    else
      
      @hop = Hop.new(hop_params)

      if @hop.save
        @current_user.backlogs.create(:description => 'Nova Solicitação: ' + @hop.name)
        redirect_to client_projects_path(@hop.stage.core), notice: 'Solicitação enviada com Sucesso'
      else
        redirect_to client_projects_path(@hop.stage.core), notice: 'Erro ao enviar solicitação'
      end

    end
  end

  def admin_approve
    @hop = Hop.find(params[:id])
    
    @hop.approved = true
    @hop.approved_user = @current_user.id
    if @hop.save
      if @hop.recursive
        stage = Stage.find(@hop.next_stage) rescue nil
        if !stage.nil?
          stage.hops.create(:name => @hop.name, :recursive => false)
        end
        @current_user.backlogs.create(:description => 'Aprovou o item '+@hop.name)

        redirect_to stage_path(@hop.stage.id)
      else
        redirect_to stage_path(@hop.stage.id)
      end
    else
      redirect_to stage_path(@hop.stage.id), alert: 'Nao foi possivel aprovar!'
    end
    # redirect_to client_projects_path(@hop.stage.core.id)
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
    @current_user.backlogs.create(:description => 'Deletou o item ' + hop.name)
    hop.destroy()
    redirect_to stage_path(stage)
  end

  private
    def hop_params
      params.require(:hop).permit(:name,:next_stage,:recursive,:picture,:stage_id,:status,:priority,:priority,:estimated_time,:versao,:has_image,:picture,:cleared)
    end
end
