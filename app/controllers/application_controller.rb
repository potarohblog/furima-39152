class ApplicationController < ActionController::Base
    before_action :basic_auth
  
  
    private
  
    def basic_auth
        # 'admin'というユーザー名と、'2222'というパスワードでBasic認証できるように設定
      authenticate_or_request_with_http_basic do |username, password|
        username == 'admin' && password == '2222'
      end
    end
  end