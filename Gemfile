source 'https://rubygems.org'

gem 'httparty'
gem 'rake'
gem 'rbs'
group :development, :test do
  %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
    gem lib, git: "https://github.com/rspec/#{lib}.git", branch: 'main'
  end
  gem 'rufo'
end
