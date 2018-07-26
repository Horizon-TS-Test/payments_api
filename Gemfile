source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
#gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
#gem 'coffee-rails', '~> 4.2'
# Use jquery as the JavaScript library
#gem 'jquery-rails'
# gema de postgres
gem 'pg','~> 0.21.0'
# Turbolinks makes navigating your web application faster
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease.
gem 'jbuilder', '~> 2.5'

########################### aumente ##########
#Devise para autenticacion
gem "devise"
#HAML para crear un mejor HTML
#gem "haml-rails"
# Boostrap 
gem "bootstrap-sass"
# Tema Material Design para bootstrap
gem "bootstrap-material-design"
#Paperclip para subir imagenes
#gem 'paperclip' 
#PayPal SDK
gem 'paypal-sdk-rest'
# maquinas de estado Aasm 
gem 'aasm'
# Credit Card Validator
gem "credit_card_validator"

#################################################
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.11'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  #Anotacion de los modelos
  gem 'annotate'
end

group :production do
  #gem 'mysql2', '~> 0.3.9'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
