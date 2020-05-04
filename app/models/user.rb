class User < ActiveRecord::Base

   has_secure_password

   validates :first_name, presence: true
   validates :last_name, presence: true
   validates :password, presence: true, length: { minimum: 8}
   validates :password_confirmation, presence: true
   validates_uniqueness_of :email, case_sensitive: false
   validates :email, presence: true
   

   def self.authenticate_with_credentials(email, password)
      user = User.find_by_email(email.strip.downcase)
      if user && user.authenticate(password)
          return user
        else 
          return nil
        end
   end
   
end
