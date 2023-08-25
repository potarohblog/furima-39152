class ItemsController < ApplicationController
  # ログインしていない時はnew、edit、update、destroyのページに遷移できないようにする
  before_action :authenticate_user!, only: [:new, :edit, :update]

  # 重複処理をまとめる
  # before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      ログインしていない時は
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
    #違うユーザーが投稿を編集するページにアクセスできないようにする
    if @item.user != current_user
      redirect_to root_path
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  # def destroy
  #   # ログインしているユーザーと同一であればデータを削除する
  #   if @item.user_id == current_user.id
  #     @item.destroy
  #     redirect_to root_path
  #   else
  #     redirect_to root_path
  #   end
  # end

  private

  def item_params
    params.require(:item).permit(
      :image,
      :title,
      :text,
      :category_id,
      :sales_status_id,
      :shipping_cost_id,
      :prefecture_id,
      :scheduled_delivery_id,
      :price
    ).merge(user_id: current_user.id)
  end

#   def set_item
#     @item = Item.find(params[:id])
#   end
end