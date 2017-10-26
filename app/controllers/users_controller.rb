class UsersController < ApplicationController

  # GET /users/1
  def show
    @user =User.find(params[:id]) #params[:id]は文字列型の"1"だが、findメソッドが自動で整数型に変換する
    #debugger
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    #Rails4.0以降ではエラーとなる(マスアサインメント脆弱性回避のため)
    #ハッシュで初期化すると、admin: '1'という値をクライアント側から渡せてしまうのは極めて危険
    #@user = User.new(params[:user])
    @user = User.new(user_params)
    if @user.save
      @user.save
    else
      #パーシャルで使用したrenderと同じメソッド
      render 'new'
    end
  end

  #private 以降をインデントを下げることで、privateが見つけやすくなる
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
