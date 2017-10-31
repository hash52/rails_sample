class UsersController < ApplicationController
  # 指定の処理が実行される直前に特定のメソッドを実行する仕組み
  # onlyをつけないと、全てのアクションに制限の範囲が及ぶ
  before_action :logged_in_user,only:[:index, :edit, :update]
  before_action :correct_user, only:[:edit, :update]

  def index
    @users = User.all
  end
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
      log_in @user
      # flash変数に代入したメッセージは、リダイレクトした直後のページのみ表示する
      # :successに成功時のメッセージを代入するのは強制ではないが、Railsの慣習
      flash[:success] = "Welcome to the Sample App!"

      #redirect_to user_url(@user)と等価
      # /users/@user.idにリダイレクトする
      redirect_to @user
    else
      #パーシャルで使用したrenderと同じメソッド
      render 'new'
    end
  end

  # GET /users/id/edit
  def edit
    @user = User.find params[:id]
    # @user = User.find_by id:params[:id]
  end

  # PATCH /users/id/edit
  def update
    @user = User.find(params[:id])
    # debugger
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  #private 以降をインデントを下げることで、privateが見つけやすくなる
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger]="Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user? @user

    end
end
