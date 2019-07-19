class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def ensure_correct_user
    @current_user = User.find_by(id:  session[:user_id])
    if @current_user.id !=  params[:id].to_i
      redirect_to tasks_path
    end
  end
end
