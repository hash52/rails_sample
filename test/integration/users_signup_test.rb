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
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    # 送信に失敗したときにnewアクションが再描画される
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'

  end
end
