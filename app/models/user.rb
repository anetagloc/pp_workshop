class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :timeoutable

  EMAIL_REGEX = Devise.email_regexp

  validates :username, presence: true
  validates :email , presence: true, uniqueness: { case_sensetive: false }, format: { with: EMAIL_REGEX }
  validates :password, presence: true


  has_many :articles, dependent: :nullify
  
  # Permitted additional params for devise
  def self.ransackable_attributes(auth_object = nil)
    super + ['username'] 
  end
end
