# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# サンプルユーザの生成
# rails db:migrate:reset
# rails db:seed　で実行

# create! createと基本は同じだが、ユーザが向こうの場合にfalseではなく例外を発生させる
# 見過ごしやすいエラーを回避でき、デバッグが容易になる
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)
             #admin属性を追加すると自動でadmin?メソッドが使用できるようになる
             #user.admin?
             #user.toggle!(:admin)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
