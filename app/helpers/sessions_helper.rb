module SessionsHelper
  # 渡されたユーザでログインする
  def log_in(user)
    # Railsのsessionメソッド。sessionsコントローラとは無関係
    # ユーザーのブラウザ内の一時cookiesに暗号化済みのユーザーIDが作成される
    session[:user_id] = user.id
  end
end
