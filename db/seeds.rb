User.create!(name: "trinhdvt", email: "dvt@gmail.com",
             password: "illusion", password_confirmation: "illusion",
             admin: true, activated: true,
             activated_at: Time.zone.now)

50.times do |i|
  name = Faker::Name.name
  email = "trinhdvt-#{i + 1}@gmail.com"
  password = "illusion"
  User.create!(name: name, email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end
