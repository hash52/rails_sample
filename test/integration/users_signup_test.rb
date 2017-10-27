require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid signup information" do
    #ユーザ登録ページにアクセス
    #(なくてもPOSTできるが、テストのコンセプトを明確にするのと、登録ページのダブルチェックを兼ねるために呼び出す)
    get signup_path
    #ブロックを実行した前後で、User.countの値が変わらないことをテスト
    assert_no_difference 'User.count' do
      #users_pathに登録失敗するPOSTリクエストを送信
      post signup_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    # 送信に失敗したときにnewアクションが再描画される
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select "form[action=?]",signup_path
  end


  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    # POSTリクエストを送信した結果を見て、指定されたリダイレクト先に移動するメソッド
    follow_redirect!
    assert_template 'users/show' #usersコントローラのshowメソッド
    assert flash.any?
    assert is_logged_in?
  end
end
