source 'https://rubygems.org'
ruby '2.1.0'

gem 'rails', '4.0.0'
gem 'dotenv-rails', :groups => [:development, :test] # has to be loaded before any ENVs
gem 'puma', '~> 2.3'

# Web
gem 'jquery-rails', '~> 3.0'
gem 'haml', '~> 4.0'
gem 'bootstrap-sass', '~> 2.3.2'
gem 'sass-rails',   '~> 4.0'
gem 'coffee-rails', '~> 4.0'
gem 'uglifier'
# Models
gem 'state_machine'

# DB
gem 'pg'
gem 'foreigner'

# Utils
gem 'magic_encoding'
gem 'foreman' # to run Puma on Heroku
gem 'bcrypt-ruby', '~> 3.0.0' # must match the version in active_model/secure_password.rb
gem 'nokogiri', '~> 1.5'
gem 'http_accept_language'
gem 'rails_12factor', group: :production

group :development do
  gem 'annotate', '>= 2.5.0'
  gem 'haml-rails', '~> 0.4'
end

group :test do
  gem 'sqlite3'
  gem 'capybara', '~> 2.1'
  gem 'minitest', '~> 4.7'
  gem 'minitest-reporters', '>= 0.5.0'
  gem 'minitest-spec-rails', '~> 4.7'
  gem 'minitest-capybara', '~> 0.4'
end

group :development, :test do
  gem 'factory_girl_rails', '~> 4.1' # Needs to be in the development group to generate factory files instead of *.yml files
end
