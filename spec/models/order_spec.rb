require 'rails_helper'

describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  describe '商品出品' do
    context '商品出品がうまくいくとき' do
      it '全ての項目が入力されていれば出品ができる' do
        expect(@order).to be_valid
      end
    end

    context '商品出品がうまくいかないとき' do
      it '' do
      end
    end
  end
end