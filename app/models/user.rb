class User < ActiveRecord::Base

  has_and_belongs_to_many :groups
  has_and_belongs_to_many :orders
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower



  scope :name_like, -> (name) { where("name like ? ", name)}

  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable, :lockable, :zxcvbnable,
       :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  #VALID_PHONE_REGEX = /\A^01[0-2]\d{8}$\z/
  #validates :phone, format: { with: VALID_PHONE_REGEX }


	def send_devise_notification(notification, *args)
	  devise_mailer.send(notification, self, *args).deliver_later
	end

	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
	    user.name = auth.info.name   # assuming the user model has a name
	    #user.image = auth.info.image # assuming the user model has an image
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
