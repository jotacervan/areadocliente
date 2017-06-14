class ConversationsController < ApplicationController

  before_action :user_authenticate
  
  def index
  end

  def create
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
  end
  
  private 
    def conversations_params
      params.require(:conversation).permit(:sender_id,:recipient_id)
    end
end