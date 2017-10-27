class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # 全コントローラでSessionHelperが使えるようになる
  # Sessionsコントローラを生成した時点でモジュールが自動生成されており、ビューにも自動で読み込まれる
  include SessionsHelper

  def hello
    render html:"hello,world!"
  end
end
