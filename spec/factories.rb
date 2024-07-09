FactoryBot.define do

    factory(:article) do
        title { Faker::Lorem.sentence(word_count: 2 ) }
        body { Faker::Lorem.paragraph(sentence_count: 3) }
        published { [true, false].sample() } 
        trait :with_image do
            after(:build) do |article|
                article.image.attach(io: File.open(Rails.root.join('spec', 'support', 'assets', 'sample_image.jpg')), filename: 'sample_image.jpeg', content_type: 'image/jpeg')
            end      
            end
    end
    factory(:user) do
        username { Faker::Internet.username }
        email { Faker::Internet.email }
        password { "Password1" }
      end
    end
    