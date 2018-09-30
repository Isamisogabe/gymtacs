class User < ApplicationRecord
  before_save { self.email.downcase! }
  mount_uploader :image, ImageUploader
  # バリデーション
  validates :image, length: { maximum: 50000 }
  validates :description, length: { maximum: 100 }
  validates :belong, length: { maximum: 30 }
  validates :location, length: { maximum: 30 }
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
                    
  
  has_many :items
  has_many :relationships ,dependent: :destroy
  has_many :followings, through: :relationships, source: :follow 
  has_many :reverses_of_relathionship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relathionship, source: :user
  
  #favorite機能・pick機能
  has_many :favorites, dependent: :destroy
  has_many :favorite_items, through: :favorites, source: :item
  has_many :picks, dependent: :destroy
  has_many :pick_items, through: :picks, source: :item
  
  
  
  def pick?(item)
    self.pick_items.include?(item)
  end
  
  def pick(item)
    self.picks.find_or_create_by(item_id: item.id )
  end
  
  def unpick(item)
    pick = self.picks.find_by(item_id: item.id)
    pick.destroy if pick
  end
  
  def favorite?(item)
    self.favorite_items.include?(item)
  end
  
  def favorite(item)
    self.favorites.find_or_create_by(item_id: item.id )
  end
  
  def unfavorite(item)
    favorite = self.favorites.find_by(item_id: item.id)
    favorite.destroy if favorite
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def feed_items
    Item.where(user_id: self.following_ids + [self.id], isdraft: false)
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  # 暗号化メソッド
  has_secure_password
end
