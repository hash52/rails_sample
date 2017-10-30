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

  # sessionハッシュとpostを使わずに、テストユーザとしてログインする
  def log_in_as(user)
    session[:user_id] = user.id
  end
end

class ActionDispatch::IntegrationTest
  # 統合テストで扱うヘルパー

  # テストユーザーとしてログインする
  # 単体テストか統合テストか意識せずに、ログイン済みの状態をテストしたい時はlog_in_asを呼び出せばいい＝ダックタイピングの一種
  def log_in_as(user, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: user.email,
                                          password: password,
                                          remember_me: remember_me } }
  end
end
