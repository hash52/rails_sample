require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  #setupメソッドは各テストが走る直前に実行される。ここで宣言したインスタンス変数は、すべてのテスト内で使えるようになる
  def setup
    #? ハッシュをシングルクォートにするとエラーになる。
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  test "should be valid" do
    #Model定義そもそもがおかしければFailedとなるテスト
    assert @user.valid?
  end

  test "name should be present" do
    #valid?でfalseが返って来ればOKなテスト。validationが正しく実装されていなければtrueが返ってきてしまい、結果はFailedとなる
    @user.name = "   "
    assert_not @user.valid?
    #assert @user.invalid?　でも可(というか、否定の否定はわかりずらいのでこっちの方がいいのでは？)
  end

  test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert @user.invalid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert @user.invalid?
  end
end
