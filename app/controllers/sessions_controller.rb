class SessionsController < ApplicationController

  def login

    user = User.find_by(screen_name: params[:screen_name])
    
    if user and user.authenticate(params[:password])
      secret_key = Rails.application.secret_key_base
      token = JWT.encode({
          user_id: user.id,
      }, secret_key)
      session[:token] = token
      redirect_to user
    else
      flash[:message] = "Unable to verify screen name or password please try again."
      redirect_to new_session_path
    end
  end

  def logout
    session[:token] = nil
    redirect_to root_path
  end
end
