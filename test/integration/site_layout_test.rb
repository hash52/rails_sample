require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  #統合テスト
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]",root_path,count:2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    #assert_selectには多くのオプションがあるが、このメソッドでは複雑なテストはしない方が賢明
    #頻繁に変更されるHTML要素をテストするくらいに抑えておくべき
  end
end
