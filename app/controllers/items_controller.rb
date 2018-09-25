class ItemsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user?, only: [:destroy, :update]
  def index
    @draft_items = current_user.items.where(isdraft: true).order('created_at DESC').page(params[:page])
    @upload_items = current_user.items.where(isdraft: false).order('created_at DESC').page(params[:page])
    @item = @draft_items.first
  end
  
  def new
    @item = current_user.items.build
  end
  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    if @item.update(item_params)
      flash[:success] = "更新は成功しました"
      redirect_to items_index_path
    else
      flash[:danger] = "更新失敗しました"
      render :edit
    end
  end
  
  def show
    @item = Item.find(params[:id])
    @draft_items = current_user.items.where(isdraft: true).order('created_at DESC').page(params[:page])
    @upload_items = current_user.items.where(isdraft: false).order('created_at DESC').page(params[:page])
  end
  
  def create
    @item = current_user.items.build(item_params)
    if @item.save &&  !@item.isdraft
      flash[:success] = "記事を投稿しました"
      redirect_to items_index_path
    elsif @item.save && @item.isdraft
      flash[:success] = "記事を下書きとして保存しました"
      redirect_to items_index_path
    elsif !@item.isdraft
      flash[:danger] = "記事の投稿は失敗しました"
      render :new
    elsif @item.isdraft
      flash[:danger] = "記事の下書きを保存することができませんでした。"
      render :new
    else
      flash[:danger] = "失敗しました"
      render :new
    end
  end

  def destroy
    @item.destroy
    flash[:success] = "記事を削除しました"
    redirect_back(fallback_location: root_path)
    
  end
  private
  
  def item_params
    params.require(:item).permit(:title, :content, :isdraft)
  end
  
  def correct_user?
    @item = current_user.items.find_by(id: params[:id])
    unless @item
      redirect_to root_url
    end
  end
end
