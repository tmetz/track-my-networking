source 'http://rubygems.org'

gem 'sinatra'
gem 'sinatra-flash'
gem 'activerecord', '~> 4.2', '>= 4.2.6', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'require_all'
gem 'thin'
gem 'shotgun'
gem 'pry'
gem 'bcrypt'
#gem 'bootstrap', '~> 4.2.1'
gem "bootstrap", ">= 4.3.1"

group :production do
  gem 'pg', '~> 0.21'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end

group :development do
  gem 'sqlite3'
  gem "tux"
end
