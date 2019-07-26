# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者ユーザーの作成
@user = User.create!(
  name: 'dev_admin',
  email: 'dev@dev.com',
  password: '123456',
  password_confirmation: '123456',
  admin: 'true'
)

# 一般ユーザの作成
5.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               )
end

# 管理者ユーザ画面で表示されるタスクの作成
10.times do |n|
  date = Faker::Time.between(40.years.ago, 18.years.ago, :all).to_s[0, 10]
  Task.create(content: "テストタスク#{n}", status: "未着手", priority: "mid",deadline: date,user_id: @user.id)
end