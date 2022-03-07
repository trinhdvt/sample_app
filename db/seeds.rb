User.create!(name: "trinhdvt", email: "dvt@gmail.com",
             password: "illusion", password_confirmation: "illusion")

50.times do |i|
  name = Faker::Name.name
  email = "trinhdvt-#{i + 1}@gmail.com"
  password = "illusion"
  User.create!(name: name, email: email,
               password: password,
               password_confirmation: password)
end
