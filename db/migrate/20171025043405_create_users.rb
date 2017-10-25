class CreateUsers < ActiveRecord::Migration[5.1]
  #DBに与える変更を定義している
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      #created_at, updated_at 2列のマジックカラムを作成する。
      t.timestamps
    end
  end
end
