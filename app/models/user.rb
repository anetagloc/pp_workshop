class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :timeoutable

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
end
