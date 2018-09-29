class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'
  
  def self.ranking
    self.group(:user_id).order("count_user_id DESC").limit(10).count(:user_id)
  end
  
  validates :user_id, presence: true
  validates :follow_id, presence: true
end
