class ToppagesController < ApplicationController
  def index
    @user = User.new
    
    @items = Item.all.order("created_at DESC").page(params[:page])
    
  end
  
  def trend
    
  end
  
  def timeline
    if logged_in?
      @items = current_user.feed_items.order('created_at DESC').page(params[:page])
    end
  end
  
  def like
    if logged_in?
      @items = current_user.favorite_items.page(params[:page])
    end
  end
  
  def pick
    if logged_in?
      @items = current_user.pick_items.page(params[:page])
    end
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
  
  private 
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
