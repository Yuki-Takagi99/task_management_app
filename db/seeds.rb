
User.create!(
  name: 'admin',
  email: 'admin@test.com',
  password: 'adminadmin',
  password_confirmation: 'adminadmin',
  admin: 'true',
)

5.times do |n|
  User.create!(
    name: "ユーザー#{n + 1}",
    email: "user#{n + 1}@test.com",
    password: "useruser#{n + 1}",
    password_confirmation: "useruser#{n + 1}",
    admin: "false",
  )
end
