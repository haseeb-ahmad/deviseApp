class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :login
  # attr_accessible :title, :body


  def self.already_exists? (input)
  	if User.where('email = ? OR username = ?', input[:email], input[:username]).count == 0
  		false
  	else
  		true
    end
  end

    def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup


    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  
end
