
User.create!(
  name: 'admin',
  email: 'admin@test.com',
  password: '00000000',
  password_confirmation: '00000000',
  admin: 'true',
)

3.times do |n|
  User.create!(
    name: "user#{n + 1}",
    email: "user#{n + 1}@test.com",
    password: "00000000",
    password_confirmation: "00000000",
    admin: "false",
  )
end

User.all.each do |user|
  user.tasks.create!(
    title: "sample1",
    description: "sample1",
    user_id: user.id
  )
end
