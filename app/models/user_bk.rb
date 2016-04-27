class User < ActiveRecord::Base
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :orders
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }


  scope :name_like, -> (name) { where("name like ? ", name)}



# def self.create_with_omniauth(auth)
#     where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
#         p "**********************************************************************************"
#         user.email = auth.email
#         p user.email
#         user.password = "kjhjhkjhj544sdsds54"
#        # user.name = auth.info.name   # assuming the user model has a name
#         p user.name
#         p "***********************************************************************************"
#         #user.image = auth.info.image # assuming the user model has an image
#       end
#   end

  def self.create_with_omniauth(auth)
    create! do |user|

      # p "***************************************************************************"
      #   p auth
      #   p auth.info.name
      #   p auth.uid 
      #   p auth.provider

      # p "***************************************************************************"

      user.provider = auth.provider
      user.uid = auth.uid 
      user.name = auth.info.name
      user.email = auth.info.email

      user.password = "1234568skjs12"
      user.password_confirmation = "1234568skjs12"
      
    end
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end


  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end