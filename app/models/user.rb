class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
   # フォローしている
    has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    # フォローされてる
    has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy


    #フォローしている人
    has_many :follower_user, through: :followed, source: :follower
    #フォローされている人
    has_many :following_user, through: :follower, source: :followed
    # 1. followメソッド ＝ フォローする
  def follow(user_id)
   follower.create(followed_id: user_id)
  end

  # 2. unfollowメソッド ＝ フォローを外す
  def unfollow(user_id)
   follower.find_by(followed_id: user_id).destroy
  end

  # 3. followingメソッド ＝ 既にフォローしているかの確認
  def following?(user)
   following_user.include?(user)
  end

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
   validates :introduction, 
  length: { maximum: 50 }
  
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
