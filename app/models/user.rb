class User < ApplicationRecord
  # DBが常に大文字小文字を区別するインデックスを使っているとは限らない問題への対処
  # ActiveRecordのcallbackメソッドの一つ、before_save . 保存される時点で処理が実行される。
  #before_save { self.email = email.downcase } #右式のselfは省略できる
  before_save { email.downcase! } #こっちでもいい

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i #大文字で始まっているので定数
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }# uniqueness: true であるが、大文字小文字は区別しないという意味. (デフォルトでは大文字小文字を区別してしまう)
end
