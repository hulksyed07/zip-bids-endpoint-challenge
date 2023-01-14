source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0.2'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'
# Use Puma as the app server
gem 'puma', '~> 5.6.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.11', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'brakeman', '~> 5.4'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2'
  # For generaing API Documentation using rspec test cases
  gem 'rspec_api_documentation', '~> 6.1'
  gem 'rspec-rails', '~> 5.1'
  # For ensuring the code follows best practices
  gem 'rubocop', '~> 1.43', require: false
end

group :test do
  # For cleaning test database while running rspec
  gem 'database_cleaner', '~> 1.5', '>= 1.5.3'
  # For generaing Fake test data
  gem 'faker', '~> 3.1'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
