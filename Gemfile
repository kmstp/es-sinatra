source "https://rubygems.org"
ruby "2.5.1"

gem 'rake'
# let's use the latest and greatest
gem 'sequent', git: 'https://github.com/zilverline/sequent', branch: 'sequent-30'

group :test, :development do
  gem 'pry'
end

group :test do
  gem 'rack-test'
  gem 'rspec'
  gem 'database_cleaner'
end

gem 'puma'
gem 'sinatra'