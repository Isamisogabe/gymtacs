class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :item
  
  def self.ranking
    self.group(:item_id).order("count_item_id DESC").limit(10).count(:item_id)
  end
  
  
  validates :user_id, presence: true
  validates :item_id, presence: true
end
