class PicksController < ApplicationController
  before_action :require_user_logged_in
  def create
    item = Item.find(params[:item_id])
    current_user.pick(item)
    flash[:success] = '記事をファイルに登録しました'
    redirect_to item
  end

  def destroy
    item = Item.find(params[:item_id])
    current_user.unpick(item)
    flash[:success] = '記事をファイルからはずしました'
    redirect_to root_url
  end
end
