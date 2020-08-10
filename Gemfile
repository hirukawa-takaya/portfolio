source 'https://rubygems.org'
ruby "2.6.6"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.2.2'
gem 'bootsnap'
gem 'puma'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jbuilder'
gem 'tzinfo-data'
gem 'bootstrap-sass'
gem 'bcrypt'
gem 'jquery-rails'
gem 'font-awesome-sass'
gem 'kaminari'
gem 'rails-i18n'
gem "aws-sdk-s3", require: false
gem 'mini_magick'
gem 'ransack'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
end

group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'spring-commands-rspec'
  gem 'sqlite3'
end

group :test do
  gem 'rails-controller-testing'
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'guard'
  gem 'guard-minitest'
  gem 'capybara'
  gem 'launchy'
  gem 'webdrivers'
end

group :production do
  gem 'pg'
end