source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '~> 1.0'
gem 'hanami-model', '~> 1.0'

gem 'pg', '~> 0.20.0'
gem 'haml'

gem 'hanami-bootstrap'
gem 'jquery-hanami'

# Authentication
gem 'warden'

# Encryption
gem 'bcrypt'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun'

  gem 'rubocop'
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
  gem 'byebug', platform: :mri
  gem 'pry', platform: :mri
end

group :test do
  gem 'capybara'
  gem 'rspec'
  gem 'database_cleaner'
end

group :production do
  # gem 'puma'
end
