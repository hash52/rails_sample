class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # authenticate ・・ has_secure_passwordが提供するメソッド
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
    else
      # エラーメッセージを作成する(sessionはActiveRecodのモデルではないのでerrorsオブジェクトを持っていない)
      flash[:danger] = 'Invalid email/password combination'
      # bug! renderでテンプレートを強制的に再レンダリングしてもリクエストとみなされないため、flashメッセージが残り続けてしまう
      render 'new'
    end
  end

  def destroy
  end
end
