class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'
  
  def self.ranking
    self.group(:item_id).order("count_item_id DESC").limit(10).count(:item_id)
  end
  
  validates :user_id, presence: true
  validates :follow_id, presence: true
end
