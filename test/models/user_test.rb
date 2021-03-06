require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  #setupメソッドは各テストが走る直前に実行される。ここで宣言したインスタンス変数は、すべてのテスト内で使えるようになる
  def setup
    #? ハッシュをシングルクォートにするとエラーになる。
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
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

  test "email validation should accept valid addresses" do
    # %w[a b c] -> ["a","b"","c"]　文字列の配列を素早く作れるテクニック　
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_adress|
      @user.email = valid_adress
      #第二引数にエラーメッセージを指定。どのemailでテストが失敗したのか特定する。
      assert @user.valid?, "#{valid_adress.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert @user.invalid?, "#{invalid_address} should be invalid"
    end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    #メールアドレスは通常、大文字小文字区別されないので、大文字に直してからテストする必要がある
    duplicate_user.email = @user.email.upcase
    @user.save
    assert duplicate_user.invalid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present(nonblank)" do
    @user.password = @user.password_confirmation = " " * 6 #多重代入
    assert @user.invalid?
  end

  test "passwd should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert @user.invalid?
  end

  # 異なるブラウザで、連続でログアウトしたとき、後発がエラーになるバグのテスト
  test "authenticated? should return false for a user with nil digest" do
    # 記憶トークンが使われる前にエラーとなるので、記憶トークンの値は空で構わない
    assert_not @user.authenticated?('')
  end
end
