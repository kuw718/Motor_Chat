require 'fileutils'
safe_tmp = File.expand_path('bundle_tmp', __dir__)
FileUtils.mkdir_p(safe_tmp)
ENV['TMPDIR'] = safe_tmp
ENV['BUNDLE_TMP'] = safe_tmp

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'rails', '~> 6.1.7', '>= 6.1.7.7'
gem 'puma', '~> 3.11'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'image_processing', '~> 1.2'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise'
gem 'dotenv-rails'
gem 'kaminari'

# ⚠️ SQLite3 はローカル開発用
group :development, :test do
  gem 'sqlite3', '~> 1.4'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.5'
  gem 'spring'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'webdrivers'
end

# ✅ 本番環境で必要な gem
group :production do
  gem 'mysql2'
end

# ✅ これらの gem は production でも必要
gem 'net-smtp'
gem 'net-pop'
gem 'net-imap'
gem 'net-protocol'
gem 'timeout'

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
