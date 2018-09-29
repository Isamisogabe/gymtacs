class ToppagesController < ApplicationController
  before_action :require_user_logged_in, only: [:timeline, :pick, :like]
  before_action :set_follow_favorite_ranking, only: [:index, :timeline, :like, :pick]
  def index
    @user = User.new
    if logged_in?
      @items = Item.all.order("created_at DESC").page(params[:page])
    else
      @items = Item.all.order("created_at DESC").page(params[:page])
    end
    
  end
  
  def timeline
    @items = current_user.feed_items.order('created_at DESC').page(params[:page])
  end
  
  def like
    @items = current_user.favorite_items.page(params[:page])
  end
  
  def pick
    @items = current_user.pick_items.page(params[:page])
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
  
  def set_follow_favorite_ranking
    @favorite_ranking_counts = Favorite.ranking
    @favorite_items = Item.find(@favorite_ranking_counts.keys)
    @follow_ranking_counts = Relationship.ranking
    @follow_users = User.find(@follow_ranking_counts.keys)
  end
end
