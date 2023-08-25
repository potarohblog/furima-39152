class ItemsController < ApplicationController
  # ログインしていない時はnew、edit、update、destroyのページに遷移できないようにする
  before_action :authenticate_user!, only: [:new, :edit, :update]

  # show、edit、update,、destroy時に「@item = Item.find(params[:id])」の処理を行う
  before_action :set_item, only: [:show, :edit, :update]

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
      # ログインしていない時は商品出品ページに飛ぶ
      render :new
    end
  end

  def edit
    #違うユーザーが投稿を編集するページにアクセスできないようにする
    if @item.user != current_user
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit
    end
  end

  def show
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

  def set_item
    @item = Item.find(params[:id])
  end
end