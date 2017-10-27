module SessionsHelper
  # 渡されたユーザでログインする
  def log_in(user)
    # Railsのsessionメソッド。sessionsコントローラとは無関係
    # ユーザーのブラウザ内の一時cookiesに暗号化済みのユーザーIDが作成される
    # cookiesメソッドで作成される永続的セッションに比べてセッションハイジャックの可能性が低い
    session[:user_id] = user.id
  end

  #現在ログイン中のユーザを返す
  def current_user
    # ||= or equal @current_user = @current_user || User.find_by(id:session[:user_id])と等価
    # @current_userがnilではなければ(存在していれば)、find_byは評価されない
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
end
