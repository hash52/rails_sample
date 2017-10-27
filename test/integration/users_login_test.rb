require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

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
end
