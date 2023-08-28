class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validate do
          password_complexity
         end

        # 出品機能
        has_many :items

        # 購入機能
        has_many :orders
        
        # ニックネームが空欄だと入力できないようにする
        with_options presence: true do
          validates :nickname
          validates :birthday
          
          with_options format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/} do
            validates :last_name
            validates :first_name
          end
          
          with_options format: {with: /\A[ァ-ヶー－]+\z/} do
            validates :last_name_kana
            validates :first_name_kana
          end
      
          
        end
      
        private
      
        def password_complexity
          if password.present? && !password.match?(/\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i)
            errors.add(:password, "is invalid")
          end
        end
end