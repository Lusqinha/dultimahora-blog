# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "🧹 Cleaning up the database..."
Session.delete_all
Post.delete_all
User.delete_all
ActionText::RichText.delete_all rescue nil

puts "👤 Creating main user..."
main_user = User.create!(
  name: "Lucas Administrador",
  email_address: "lucas@example.com",
  password: "password123",
  password_confirmation: "password123"
)

puts "👥 Creating additional users..."
users = 3.times.map do |i|
  User.create!(
    name: "User #{i + 1}",
    email_address: "user#{i + 1}@example.com",
    password: "password123",
    password_confirmation: "password123"
  )
end

users_for_posts = [main_user] + users

puts "📝 Creating posts..."
20.times do |i|
  author = users_for_posts.sample
  Post.create!(
    title: "Notícia de Última Hora #{i + 1} sobre o Mundo 🌍",
    content: "<h1>Um conteúdo interessante</h1><p>Este é o conteúdo principal da <strong>notícia #{i + 1}</strong>. Aqui nós falamos detalhadamente sobre o que está acontecendo no mundo hoje.</p><br><p>Fique com a gente para mais novidades.</p>",
    user: author
  )
end

puts "✅ Database seeded successfully com #{User.count} usuários e #{Post.count} posts!"
