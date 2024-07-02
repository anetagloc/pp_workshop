# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# metoda modelu
# require 'faker'

# #create articles
# 5.times do
#     Article.create(title: Faker::Book.title, body: Faker::Lorem.sentence(word_count: 3), published: Faker::Boolean.boolean)
# end

#factory bot

require 'factory_bot_rails'
include FactoryBot::Syntax::Methods

puts "Starting"

10.times do
  create(:article)
end

puts "Ended"