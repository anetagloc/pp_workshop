FactoryBot.define do
    factory(:article) do
        title { Faker::Lorem.sentence(word_count: 4 ) }
        body { Faker::Lorem.paragraph(sentence_count: 3) }
        published { [true, false].sample() } 
        trait :with_image do
            after(:build) do |article|
                article.image.attach(io: File.open(Rails.root.join('spec', 'support', 'assets', 'sample_image.jpg')), filename: 'sample_image.jpeg', content_type: 'image/jpeg')
            end      
            end
    end
end