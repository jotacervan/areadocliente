class Webservices::HopsController < ApplicationController
	skip_before_filter :verify_authenticity_token

	api :POST, '/hops/new'
	param :name, String
	def new
	end

	api :POST, '/hops/edit'
	param :id, Integer
	def edit
		user_authenticate
		
		if @current_user.nil?
			render json: { :message => 'Faça o login para continuar.' }, :status => 302
		else
			hop = Hop.find(params[:hop][:id])
			if hop.update(hop_params)
				render json: { :message => hop.name + ' atualizado com sucesso' }, :status => 200
			else
				render json: { :message => 'Erro ao atualizar.' }, :status => 200
			end	
		end	
	end

	api :GET, '/hops/priority/:id'
	param :id, String
	def priority
		user_authenticate

		if @current_user.nil?
			render json: { :message => 'Faça o login para continuar.' }, :status => 302
		else
			hop = Hop.find(params[:id])
			if hop.update(:priority => params[:priority])
				render json: { :message => hop.name + ' atualizado com sucesso' }, :status => 200
			else
				render json: { :message => 'Erro ao atualizar.' }, :status => 200
			end	
		end
	end

	api :GET, '/hops/show'
	def show
	end

	api :GET, '/hops/show_all'
	param :name, String
	def show_all
	end

	private
		def hop_params
			params.require(:hop).permit(:name,:next_stage,:recursive,:picture,:stage_id,:status,:priority)
		end

end
