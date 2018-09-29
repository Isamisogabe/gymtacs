class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  # ユーザーが持つアイテム、フォロー、フォローわーの数
  def counts(user)
    @count_items = user.items.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
  end
  # アイテムが持つお気にいりの数
  def count_users(item)
    @count_user = item.favorite_users.count
  end
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end
