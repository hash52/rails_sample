class AddRememberDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    # ユーザが直接読み出すことはないので、インデックスは不要
    add_column :users, :remember_digest, :string
  end
end
