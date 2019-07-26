class LavelsController < ApplicationController
  def index
    @lavels = Lavel.all
  end

  def new
    @lavel = Lavel.new
  end

  def create
    Lavel.create(lavel_params)
    redirect_to new_lavel_path
  end

  def destroy
    @lavel = Lavel.find(params[:id])
    @lavel.destroy
    redirect_to lavels_path
  end

  private

  def lavel_params
    params.require(:lavel).permit(:name)
  end
end
