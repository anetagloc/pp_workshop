class Article < ApplicationRecord
    validates :title, presence: true, length: { minimum: 2, maximum: 30 }
    validates :body, presence: true, length: { minimum: 15, maximum: 300 }
    validates :published, presence: true, inclusion: [true, false], allow_blank: true
    
    has_one_attached :image
    belongs_to :user, optional: true
end
