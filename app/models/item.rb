class Item < ApplicationRecord
  
  belongs_to :user
  
  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :isdraft, presence: true
end
