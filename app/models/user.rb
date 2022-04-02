class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_one_attached :profile_image

  #ユーザーがフォローしているときの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy

  #user.followingsでフォローしているユーザーを表示できるようにする
  has_many :followings, through: :relationships, source: :followed

  #ユーザーがフォローされているときの関係
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  #user.followersという記述でフォローワーを表示出来るように設定する
  has_many :followers, through: :reverse_of_relationships, source: :follower



  # 1文字以上75文字以下の時は
  #validates :content, {length: {in: 1..75} }
  validates :name, {length: {in: 2..20} }

  validates :name, uniqueness: true

  validates :introduction, {length: {maximum: 50}}


  def get_profile_image
    if profile_image.attached?
      profile_image
    else
      'no_image.jpg'
    end
  end
end
