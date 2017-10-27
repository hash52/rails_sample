require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    #fixtureのusers.ymlのmichaelを取得
    @user = users(:michael)
  end

  # flashが残り続けるbugに対するテストを記述
  test "login with invalid information" do
    # ログイン用のパスを開く
    get login_path
    # セッションのフォームが正しく表示される
    assert_template 'sessions/new'
    # 無効なparamsでセッション用パスにPOSTする
    post login_path, params: { session: { email:"", password:""}}
    # セッションのフォームが再表示される
    assert_template 'sessions/new'
    # flashメッセージが追加される
    assert flash.any?
    # 別のページに移動する
    get root_path
    # flashメッセージが表示されていないことを確認する
    assert flash.empty?
  end

  test "login with valid information" do
    get login_path
    post login_path, params: { session: { email:@user.email, password:'password' }}
    assert_redirected_to @user
    # リダイレクト先が正しいかチェック
    follow_redirect!
    assert_select "a[href=?]",login_path, count:0
    assert_select "a[href=?]",logout_path
    assert_select "a[href=?]",user_path(@user)
  end
end
