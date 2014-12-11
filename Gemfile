source 'https://rubygems.org'

# ruby version
ruby "2.1.1"

# rails
gem 'rails', '4.1.5'

# database
gem 'pg'

# assets: sass/css
gem 'sass-rails', '~> 4.0.3'
gem 'normalize-rails'
gem 'bourbon'
gem 'neat', '1.5.1' # need 1.5.1 for sass-rails support

# assets: javascript
gem 'uglifier', '>= 1.3.0'

# assets: coffeescript/javascript
gem 'coffee-rails', '~> 4.0.0'

# assets: jquery
gem 'jquery-rails'

# turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'

# forms
gem 'simple_form'
gem 'cocoon'

# parse haml views
gem 'haml'

# parse rabl for json views
gem 'rabl'

# authentication
gem 'devise'

# authorization
gem 'pundit'

# omniauth
gem 'omniauth-google-oauth2'

# server
gem 'unicorn'

group :doc do

  # documentation
  gem 'sdoc', '~> 0.4.0'

end

group :development, :test do

  gem 'rspec-rails' # rspec
  gem 'capybara' # dsl
  gem 'factory_girl' # factories
  gem 'fuubar' # output formatting

end

group :production do

  # enable some heroku functionality
  gem 'rails_12factor'

end
