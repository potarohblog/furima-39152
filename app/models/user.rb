class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        #  出品機能
  # has_many :items
  # 購入機能
  # has_many :orders

  with_options presence: true do
    validates :nickname

    with_options format: {with: /\A[ぁ-んァ-ン一-龥]/} do
      validates :last_name
      validates :first_name
    end

    with_options format: {with: /\A[ァ-ヶー－]+\z/} do
      validates :last_name_kana
      validates :first_name_kana
    end

    validates :birthday
  end

end