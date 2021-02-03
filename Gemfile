# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

gem "decidim", "0.22.0"
gem "figaro", "~> 1.2"
gem "decidim-debates", "0.22.0"
gem "decidim-comments", "0.22.0"
gem "decidim-proposals", "0.22.0"
#gem "decidim-questions", git: "https://github.com/beyowi/decidim-questions.git"
gem "decidim-opinions", git: "https://github.com/beyowi/decidim-opinions.git", branch: "release/0.22-stable"

gem "bootsnap", "~> 1.3"

gem "puma", ">= 4.3.5"
gem "uglifier", "~> 4.1"

gem "faker", "~> 1.9"
gem "fog-aws"

gem 'rubyzip', '>= 1.0.0'
gem 'spreadsheet', '~> 1.2'

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri

  gem "decidim-dev", "0.22.0"
end

group :development do
  gem "letter_opener_web", "~> 1.3"
  gem "listen", "~> 3.1"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console", "~> 3.5"

  gem 'capistrano'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger', '>= 0.1.1'
  gem 'capistrano-rails'
  gem 'capistrano-figaro'
end

group :production do
  gem "passenger", "~> 6.0"

  gem "delayed_job_active_record", "~> 4.1"

  gem "daemons", "~> 1.3"
  gem "whenever", require: false
end
