module UsersHelper
  #引数で与えられたユーザーのGravatar画像を返す
  def gravatar_for (user, size: 80)
    #Digestライブラリのhexdigestメソッドを使いMD5でハッシュ化する
    #MD5ハッシュでは大文字小文字を区別されるので、渡す値は全て小文字にしておく
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    #imgタグを返す
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
