class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # authenticate ・・ has_secure_passwordが提供するメソッド
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in user
      redirect_to user
    else
      # エラーメッセージを作成する(sessionはActiveRecodのモデルではないのでerrorsオブジェクトを持っていない)
      flash.now[:danger] = 'Invalid email/password combination'
      # レンダリングが終わっているページにflashメッセージを表示させ、その後リクエストが発生した時に消滅する
      render 'new'
    end
  end

  def destroy
  end
end
