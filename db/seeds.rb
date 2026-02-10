# Create 1 admin user.
admin = User.create!(name:  "Admin User",
                     email: "admin@example.com",
                     password:              "password",
                     password_confirmation: "password",
                     admin:     true,
                     activated: true,
                     activated_at: Time.zone.now)

# Create 5 normal users.
normal_users = []
5.times do |n|
  name  = Faker::Name.name
  email = "user-#{n+1}@example.com"
  normal_users << User.create!(name:  name,
                               email: email,
                               password:              "password",
                               password_confirmation: "password",
                               activated: true,
                               activated_at: Time.zone.now)
end

# Create 50 microposts distributed across users.
all_users = [admin] + normal_users
50.times do
  user = all_users.sample
  content = Faker::Lorem.sentence(word_count: 5)
  user.microposts.create!(content: content,
                          created_at: Faker::Time.backward(days: 30))
end

# Ensure admin has a few posts.
5.times do
  content = Faker::Lorem.sentence(word_count: 5)
  admin.microposts.create!(content: content,
                           created_at: Faker::Time.backward(days: 14))
end

# Create following relationships.
normal_users.each { |user| user.follow(admin) }
normal_users.first(3).each { |user| admin.follow(user) }
