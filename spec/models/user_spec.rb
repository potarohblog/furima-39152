require 'rails_helper'

describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "全ての項目が正しく入力されてあれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "emailに@が含まれていない場合登録できない" do
      @user.email = 'testgmail.com'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid? 
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "passwordが5文字以下であれば登録できない" do
        @user.password = "00000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password = "000000"
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "last_nameが空では登録できない" do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", "Last name is invalid")
      end

      it "first_nameが空では登録できない" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", "First name is invalid")
      end

      it "last_nameとfirst_nameが半角文字だと登録できない" do
        @user.last_name = "yamada"
        @user.first_name = "tarou"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid", "First name is invalid")
      end

      it "last_name_kanaが空だと登録できない" do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank", "Last name kana is invalid")
      end

      it "first_name_kanaが空だと登録できない" do
      @user.first_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank", "First name kana is invalid")
      end

      it "last_name_kanaとfirst_name_kanaがカタカナでないと登録できない" do
        @user.last_name_kana = "yamada"
        @user.first_name_kana = "tarou"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid", "First name kana is invalid")
      end

      it "birthdayが空では登録できない" do
      @user.birthday = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end