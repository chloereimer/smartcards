class User < ActiveRecord::Base
  
  devise  :database_authenticatable,  # stores encrypted password for user authentication
          :omniauthable,              # adds omniauth support
          # :confirmable,               # sends emails with confirmation instructions
          :recoverable,               # resets the user password & sends emails with reset instructions
          :registerable,              # handles user registration & account editing
          :rememberable,              # manages remembering the user in a cookie
          :trackable,                 # tracks sign-in count, timestamps & ip address
          :timeoutable,               # expires sessions after a period of inactivity
          :validatable,               # handles validation of email/password
          :lockable,                  # locks an account after a number of failed sign-in accounts
          omniauth_providers: [:google_oauth2]  # adds google omniauth2 as a provider

  # relationships

  has_many :decks

  # helpers

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first
    unless user
      user = User.create(
         email: data["email"],
         password: Devise.friendly_token[0,20]
      )
    end
    user
  end

end
