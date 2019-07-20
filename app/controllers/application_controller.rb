class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def ensure_correct_user
    @current_user = User.find_by(id:  session[:user_id])
    @task = Task.find_by(id:params[:id])
    if @task.user_id != @current_user.id
      flash[:notice] = "権限がありません"
    # if @current_user.id !=  params[:id].to_i
      binding.pry
      redirect_to tasks_path
    end
  end
end