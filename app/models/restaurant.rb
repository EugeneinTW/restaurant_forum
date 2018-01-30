class Restaurant < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :name

  belongs_to :category

  # 當 Restaurant 物件被刪除時，順便刪除依賴的 Comment
  has_many :comments, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  # 「使用者like很多餐廳」的多對多關聯
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def is_favorited?(user)
    self.favorited_users.include?(user)
  end

  def is_liked?(user)
    self.liked_users.include?(user)
  end
end
