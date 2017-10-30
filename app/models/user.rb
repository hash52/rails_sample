class User < ApplicationRecord
  #cookieの保存場所
  attr_accessor :remember_token
  # DBが常に大文字小文字を区別するインデックスを使っているとは限らない問題への対処
  # ActiveRecordのcallbackメソッドの一つ、before_save . 保存される時点で処理が実行される。
  #before_save { self.email = email.downcase } #右式のselfは省略できる
  before_save { email.downcase! } #こっちでもいい

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i #大文字で始まっているので定数
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }# uniqueness: true であるが、大文字小文字は区別しないという意味. (デフォルトでは大文字小文字を区別してしまう)
  validates :password, presence: true, length:{ minimum: 6 }

  # 多くの機能を使えるようになるrailsメソッド.
  # 例 仮想的なpassword属性とpassword_confirmation属性に対してバリデーションをする機能も(強制的に)追加されている
  # モデル内にpassword_digestという属性が含まれている & bcrypt gem(ハッシュ関数)を使用しているときに使用可
  has_secure_password

  # 永続セッションのために、ユーザトークンに対応する記憶ダイジェストをDBに保存する
  def remember
    # selfが無いと新規にローカル変数が作成されてしまう
    self.remember_token = User.new_token
    # update_attributesではないので、バリデーションを素通りさせる
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  #　クラスメソッドをまとめて記述できる
  class << self
    # 渡された文字列のハッシュ値を返す
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # self.new_token でもクラスメソッドの定義可能
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

end
