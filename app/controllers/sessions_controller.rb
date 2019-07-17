class SessionsController < ApplicationController
  before_action :authenticate_user, only: [:index, :new]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end

  private

  def authenticate_user
    if logged_in?
      redirect_to tasks_path
    end
  end  
end