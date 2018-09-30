class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :destroy]
  
  def show
    @user = User.find(params[:id])
    @items = @user.items.page(params[:page])
    @following_items = Item.where(user_id: @user.following_ids).page(params[:page])
    @follower_items = Item.where(user_id: @user.follower_ids).page(params[:page])
    counts(@user)
  end
  
  def account_custom_image
    @user = current_user
  end
  
  def account
    @user = current_user
  end
  
  def settings
    @user = current_user
  end
  
  def new
    @user = User.new
  end

  def create
    
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザの登録に成功しました'
      redirect_to :login
    else
      flash.now[:danger] = "ユーザの登録に失敗しました"
      render :new
    end
  end
  
  def destroy
    @user = current_user
    @user.destroy if current_user
    redirect_to root_url
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
   def update
     
    @user = current_user
    if @user.update(user_params) 
      flash[:success] = "更新しました"
      redirect_to @user
    else
      flash[:danger] = "更新できませんでした"
      render :settings
    end
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  
  private 
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :isuserimg?, :location,:belong, :description, :image)
  end
end
