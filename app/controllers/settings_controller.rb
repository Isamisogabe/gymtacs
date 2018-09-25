class SettingsController < ApplicationController
  before_action :require_user_logged_in
  
  def profile
    @user = current_user
  end
  
  def account
    @user = current_user
  end
  
  def custom_image
    @user = current_user
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "更新しました"
      redirect_to @user
    else
      flash[:danger] = "更新できませんでした"
      render :account
    end
  end
  
  private 
  
  def user_params
    params.require(:user).permit(:name, :location, :belong, :description)
  end
end
