class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name
  mount_uploader :avatar, AvatarUploader

    # 「使用者評論很多餐廳」的多對多關聯
    has_many :comments, dependent: :restrict_with_error
    has_many :restaurants, through: :comments

    # 「使用者收藏很多餐廳」的多對多關聯
    has_many :favorites, dependent: :destroy
    has_many :favorited_restaurants, through: :favorites, source: :restaurant

    # 「使用者like很多餐廳」的多對多關聯
    has_many :likes, dependent: :destroy
    has_many :liked_restaurants, through: :favorites, source: :restaurant

    has_many :followships, dependent: :destroy
    has_many :followings, through: :followships
  # admin? 讓我們用來判斷單個user是否有 admin 角色，列如：current_user.admin?
  def admin?
    self.role == "admin"
  end

end
