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

  def current_user? user
    user == current_user
  end


  #現在ログイン中のユーザを返す
  def current_user
    # 代入した結果nilじゃなければ
    if (user_id = session[:user_id])
      # ||= or equal @current_user = @current_user || User.find_by(id:session[:user_id])と等価
      # @current_userがnilではなければ(存在していれば)、find_byは評価されない
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      #raise       # テストがパスすれば、この部分がテストされていないことがわかる
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

  #永続的セッションの破棄
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    @current_user = nil
  end

  # 現在のユーザをログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # 記憶したURLもしくはデフォルト値にリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # アクセスしようとしたURLを覚えておく
  def store_location
    # ユーザがセッション用のcookieを手動で削除してフォームから送信した場合などで、
    # POSTや PATCH、DELETEリクエストを期待しているURLに対して、(リダイレクトを通して) GETリクエストが送られてしまい、場合によってはエラーになるのを防ぐため、
    # GETリクエストのときのみ格納するようにする
    session[:forwarding_url] = request.original_url if request.get?
  end
end
