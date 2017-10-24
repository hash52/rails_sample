#ApplicationControllerを継承しているのでRails特有の振る舞いをする
class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end

  def contact
  end
end
