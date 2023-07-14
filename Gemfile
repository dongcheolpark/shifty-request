# frozen_string_literal: true

source 'https://rubygems.org'

gem 'httparty'
gem 'rake'
gem 'rbs'
gem 'dotenv'
gem 'rubocop', require: false
gem 'rubocop-shopify', require: false
group :development, :test do
  ['rspec-core', 'rspec-expectations', 'rspec-mocks', 'rspec-rails', 'rspec-support'].each do |lib|
    gem lib, git: "https://github.com/rspec/#{lib}.git", branch: 'main'
  end
end
