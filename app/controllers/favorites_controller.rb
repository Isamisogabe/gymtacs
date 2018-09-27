class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  def create
    item = Item.find(params[:item_id])
    current_user.favorite(item)
    flash[:success] = '記事をお気に入りに登録しました'
    redirect_to item
  end

  def destroy
    item = Item.find(params[:item_id])
    current_user.unfavorite(item)
    flash[:success] = 'お気に入りを削除しました'
    redirect_to item
  end
end
