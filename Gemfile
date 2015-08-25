source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

gem "rails_config"

gem 'pg'

gem 'devise', '>= 3.2.1'

gem 'will_paginate'

gem 'haml-rails'


group :assets do
  gem 'bootstrap-sass', '~>2.3.2.2'
  # Use SCSS for stylesheets
  gem 'sass-rails', '~> 4.0.0'
  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '~> 1.3.0'
  # Use CoffeeScript for .js.coffee assets and views
	gem 'coffee-rails', '~> 4.0.0'
	# Use jquery as the JavaScript library
	gem 'jquery-rails'

end

group :development, :test do
  gem "rspec"
  gem "rspec-rails"
  #gem "json_spec"
  gem "faker"
  gem 'awesome_print'
  #gem 'railroady' # this causes Rake not work on windows os
end

group :test do
  # automatically manage Spork DRb servers
  # Collection of testing matchers extracted from Shoulda
  gem 'database_cleaner'
  gem 'factory_girl_rails'
end


# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby



# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
