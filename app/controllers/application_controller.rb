class ApplicationController < ActionController::Base

  include Pundit

  protect_from_forgery with: :exception

  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    render json: { error: "You're not authorized to perform that action." }, status: 403
  end

  def after_sign_out_path_for(user)
    new_user_session_path
  end
  
end
