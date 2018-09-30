class Item < ApplicationRecord
  
  belongs_to :user
  
  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  
  
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: :user
end
