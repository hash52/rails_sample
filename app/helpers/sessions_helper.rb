module SessionsHelper
  # 渡されたユーザでログインする
  def log_in(user)
    # Railsのsessionメソッド。sessionsコントローラとは無関係
    # ユーザーのブラウザ内の一時cookiesに暗号化済みのユーザーIDが作成される
    # cookiesメソッドで作成される永続的セッションに比べてセッションハイジャックの可能性が低い
    session[:user_id] = user.id
  end

  # ユーザのセッションを永続的にする
  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    # cookies[:remember_token] = { value:   remember_token,expires: 20.years.from_now.utc } と等価
    cookies.permanent[:remember_token] = user.remember_token
  end

  #現在ログイン中のユーザを返す
  def current_user
    # 代入した結果nilじゃなければ
    if (user_id = session[:user_id])
      # ||= or equal @current_user = @current_user || User.find_by(id:session[:user_id])と等価
      # @current_userがnilではなければ(存在していれば)、find_byは評価されない
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
