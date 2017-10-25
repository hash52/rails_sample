class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    # usersテーブルのemailカラムにユニークキー制約のインデックスを追加する
    add_index :users, :email, unique: true
  end
end
