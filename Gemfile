source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'dotenv-rails'
  gem 'rspec-rails', '~> 6.0.0'
  gem "sidekiq-cron"
  gem 'sidekiq', '~> 6.5'
end

group :test do
  gem 'factory_bot_rails'
  gem 'vcr', '~> 6.1.0'
  gem "webmock", '3.3.0'
end

group :production do
  gem 'rack-throttle'
end

group :development do
  gem "web-console"
end
