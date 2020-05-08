
# 管理者ユーザーの作成
User.create!(
  name: 'admin',
  email: 'admin@test.com',
  password: '00000000',
  password_confirmation: '00000000',
  admin: 'true',
)

# 一般ユーザーの作成
3.times do |n|
  User.create!(
    name: "user#{n + 1}",
    email: "user#{n + 1}@test.com",
    password: "00000000",
    password_confirmation: "00000000",
    admin: "false",
  )
end

# ユーザーに紐づくタスクの作成
User.all.each do |user|
  user.tasks.create!(
    title: "sample1",
    description: "sample1",
    user_id: user.id
  )
end

# ラベルの作成
3.times do |n|
  Label.create!(
    name: "label#{n + 1}"
  )
end
