require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end


  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title","Home | #{@base_title}"
  end

  test "should get help" do
    #route.rbの変更により名前付きルート(*_path)が使えるようになった
    get help_path
    assert_response :success
    assert_select "title","Help | #{@base_title}"
  end

  test "should get about" do
    #routes.rbを見る
    get about_path
    assert_response :success
    #指定のタグに指定の文字列があるかどうかチェックするテストメソッド(セレクタ)
    assert_select "title","About | #{@base_title}"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title","Contact | #{@base_title}"
  end

end
