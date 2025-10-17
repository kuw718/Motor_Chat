ENV['TMPDIR'] = File.expand_path('tmp', __dir__)
Dir.mkdir(ENV['TMPDIR']) unless Dir.exist?(ENV['TMPDIR'])

# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

run Rails.application
Rails.application.load_server
