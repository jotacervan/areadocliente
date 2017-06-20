class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def user_authenticate
  	if session[:user_id].nil?
      redirect_to login_path, alert: 'Faça o login para continuar'
    else
      @current_user = User.find(session[:user_id]) rescue nil
      if @current_user.nil?
        redirect_to login_path, alert: 'Faça o login para continuar'
      end
    end
  end

  def api_user_authencicate
  	if session[:user_id].nil?
      @current_user = nil
    else
      @current_user = User.find(session[:user_id]) rescue nil
    end
  end

end
