class ItemsController < ApplicationController
  # ログインしていないユーザーはログインページに促す
  before_action :authenticate_user!, except: [:index]

  # 重複処理をまとめる
  before_action :set_item, only: [:show, :edit, :update, :destroy]

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
      render :new
    end
  end

  # def edit
  #   # ログインしているユーザーと同一であればeditファイルが読み込まれる
  #   if @item.user_id == current_user.id && @item.order.nil?
  #   else
  #     redirect_to root_path
  #   end
  # end

  # def update
  #   @item.update(item_params)
  #   # バリデーションがOKであれば詳細画面へ
  #   if @item.valid?
  #     redirect_to item_path(item_params)
  #   else
  #     # NGであれば、エラー内容とデータを保持したままeditファイルを読み込み、エラーメッセージを表示させる
  #     render 'edit'
  #   end
  # end

  # def show
  # end

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