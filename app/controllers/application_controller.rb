class ApplicationController < ActionController::Base
    before_action :basic_auth
    
    # deviseコントローラー時に下記メソッドを実行
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    private
  
    def basic_auth
        # 'admin'というユーザー名と、'2222'というパスワードでBasic認証できるように設定
      authenticate_or_request_with_http_basic do |username, password|
        username == 'admin' && password == '2222'
      end
    end
    
    # 新規登録時、emailとencrypted_password以外もストロングパラメーターとして許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birthday])
  end
end