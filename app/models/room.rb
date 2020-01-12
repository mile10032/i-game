class Room < ApplicationRecord 
  has_many :messages
  has_many :room_users
  has_many :users, through: :room_users
  validates :name, presence: true, uniqueness: true

end