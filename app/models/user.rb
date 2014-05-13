class User < ActiveRecord::Base
  has_many :pizzaposts, dependent: :destroy
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :username, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
 
  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end 

  def feed
	Pizzapost.from_users_followed_by(self)
  end
 
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

end