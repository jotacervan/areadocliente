class Webservices::HopsController < ApplicationController


	api :POST, '/hops/new'
	param :name, String
	def new
	end

	api :POST, '/hops/edit'
	param :id, Integer
	def edit
		render json: params[:hop]
	end

	api :GET, '/hops/show'
	def show
	end

	api :GET, '/hops/show_all'
	param :name, String
	def show_all
	end

end
