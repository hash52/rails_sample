class UsersController < ApplicationController

  def show
    # GET /users/1
    @user =User.find(params[:id]) #params[:id]は文字列型の"1"だが、findメソッドが自動で整数型に変換する
    #debugger
  end

  def new
  end
end
