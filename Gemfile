source 'https://rubygems.org'
ruby '2.2.1'
#ruby-gemset=railstutorial_rails_4_0

#****************************************************************************************
gem 'mysql2', '~> 0.3.20'
gem 'rails', '4.2.0'
gem 'bootstrap-sass', '2.3.2.0'
gem 'sprockets', '2.11.0'
gem 'bcrypt-ruby', '3.1.2'
gem 'faker', '1.1.2'
gem 'will_paginate', '3.0.4'
gem 'bootstrap-will_paginate', '0.0.9'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'jquery-ui-rails'
gem 'rails4-autocomplete'
#*****************************************************************************************

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '2.13.1'
  gem 'guard' # NOTE: this is necessary in newer versions
  gem 'guard-minitest'
  #gem 'guard-rspec', '2.5.0'
  gem 'spork-rails', '4.0.0'
  #gem 'guard-spork', '1.5.0'
  gem 'childprocess', '0.3.6'
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '2.1.0'
  gem 'factory_girl_rails', '4.2.0'
  gem 'cucumber-rails', '1.3.0', :require => false
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
  gem 'growl', '1.0.3'
  gem 'minitest-reporters'
  gem 'mini_backtrace'
  gem 'guard'
  gem 'guard-minitest'
end


group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end
