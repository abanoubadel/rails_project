class User < ActiveRecord::Base
  include PublicActivity::Common

  has_attached_file :avatar, :styles => {:medium => "300x300>", :thumb => "100x100#"}
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

########################################## relations ##########################
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :orders
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
           class_name: "Relationship",
           dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :selfOrders, class_name: 'Order', foreign_key: 'owner_id'
  has_many :items, class_name: 'ItemsOrder'
  scope :name_like, -> (name) { where("name like ? ", name) }



  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :zxcvbnable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]


  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name # assuming the user model has a name
    end
  end


  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
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

end
