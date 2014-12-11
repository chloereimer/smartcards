Devise.setup do |config|

  # mailer configuration .......................................................

  # which sender will be shown in Devise::Mailer?
  config.mailer_sender = 'noreply@studywithsmartcards.com'

  # orm configuration ..........................................................

  # load and configure active record orm
  require 'devise/orm/active_record'

  # authentication configuration ...............................................

  # which authentication keys should be case-insensitive?
  config.case_insensitive_keys = [ :email ]

  # which authentication keys should be whitespace-stripped?
  config.strip_whitespace_keys = [ :email ]

  # should confirmation, password recovery & other workflows behave the same way
  # regardless if the email provided was right or wrong?
  config.paranoid = true

  # which strategies should devise NOT store in the session?
  config.skip_session_storage = [:http_auth]

  # database_authenticatable configuration .....................................

  # the cost for hashing passwords (assuming bcrypt)
  config.stretches = Rails.env.test? ? 1 : 10

  # confirmable configuration ..................................................

  # how long should the user be able to access the app without confirming?
  config.allow_unconfirmed_access_for = 0.days # default 0.days

  # Defines which key will be used when confirming an account
  # config.confirmation_keys = [ :email ]

  # ==> Configuration for :rememberable
  # The time the user will be remembered without asking for credentials again.
  config.remember_for = 2.weeks

  # Invalidates all the remember me tokens when the user signs out.
  config.expire_all_remember_me_on_sign_out = true

  # If true, extends the user's remember period when remembered via cookie.
  config.extend_remember_period = false

  # validatable configuration ..................................................

  # how long should the password be?
  config.password_length = 8..128

  # what regex should be used to validate the email address?
  config.email_regexp = /\A[^@]+@[^@]+\z/

  # timeoutable configuration ..................................................

  # after how long a period of inactivity should the user be logged out?
  config.timeout_in = 3.hours

  # lockable configuration .....................................................

  # what strategy should be used for locking out an account?
  config.lock_strategy = :failed_attempts

  # after how many failed login attempts should a user be locked out?
  config.maximum_attempts = 10

  # should the user be warned on their last login attempt that they will be locked out?
  config.last_attempt_warning = false

  # which key will be used when locking/unlocking an account?
  config.unlock_keys = [ :email ]

  # which strategy should be used to unlock an account?
  config.unlock_strategy = :both

  # after how long should the locked account be unlocked (if time is an unlock strategy)?
  config.unlock_in = 1.hour

  # recoverable configuration ..................................................

  # which key should be used when recovering an account's password?
  config.reset_password_keys = [ :email ]

  # for how long shouldusers be able to reset their password?
  config.reset_password_within = 6.hours

  # navigation configuration ...................................................

  # which HTTP method should be used to sign out?
  config.sign_out_via = :delete

  # omniauth configuration .....................................................

  # google oauth 2
  config.omniauth :google_oauth2, ENV['OAUTH_APP_ID'], ENV['OAUTH_APP_SECRET'], {}

end
