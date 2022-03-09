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

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each {|user| user.microposts.create!(content: content)}
end

users = User.all
user = User.first
following = users[2..30]
followers = users[3..30]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
