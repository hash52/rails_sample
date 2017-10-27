ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  #ApplicationHelperで定義したHelperメソッドをtest環境でも使用できるようにする
  include ApplicationHelper

  # Add more helper methods to be used by all tests here...
  # ヘルパーメソッドはテストから呼び出せないので、current_userを呼び出せない。sessionメソッドを使う。
  def is_logged_in?
    !session[:user_id].nil?
  end
end
