

class User < ApplicationRecord
  include Clearance::User
  validates :name, presence: true
  validates :email, :uniqueness => true, :presence => true
 # validates :password, length: { in: 6..20 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  has_many :authentications, :dependent => :destroy
  has_many :listings
  has_many :reservations
  @@fb_login = false
#In app/models/user.rb    

  def self.create_with_auth_and_hash(authentication, auth_hash)
  	#byebug
    @@fb_login = true
    user = User.create!(name: auth_hash["info"]["name"], email: auth_hash["extra"]["raw_info"]["email"])
    user.authentications << (authentication)      
    return user
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
  	if @@fb_login
  		return true
  	else
  		return false
  	end
  	@@fb_login = false
  end

end
