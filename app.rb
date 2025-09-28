# frozen_string_literal: true

require 'sinatra/base'
require 'json'
require 'logger'

class App < Sinatra::Base # :nodoc:
  # Configuration
  set :bind, ENV.fetch('HOST', '0.0.0.0')
  set :port, ENV.fetch('PORT', 4567).to_i
  set :environment, ENV.fetch('RACK_ENV', 'development')

  # External API URLs
  CONTACT_API_URL = ENV.fetch('CONTACT_API_URL', 'http://localhost:3000/contacts')
  TRACKING_API_URL = ENV.fetch('TRACKING_API_URL', 'http://localhost:3000/tracks')

  # Logging configuration
  configure do
    logger = Logger.new($stdout)
    logger.level = settings.environment == 'production' ? Logger::INFO : Logger::DEBUG
    logger.formatter = proc do |severity, datetime, progname, msg|
      "#{datetime.strftime('%Y-%m-%d %H:%M:%S')} [#{severity}] #{msg}\n"
    end

    set :logger, logger
  end

  # Request logging middleware
  before do
    logger.info "Request: #{request.request_method} #{request.path} from #{request.ip}"
  end

  after do
    logger.info "Response: #{response.status} for #{request.path}"
  end

  get '/' do
    logger.info 'Serving main page'
    File.read('views/index.html')
  end

  # Health check endpoint
  get '/health' do
    content_type :json

    health_data = {
      status: 'ok',
      app_name: ENV.fetch('APP_NAME', 'Sample Tracking'),
      version: ENV.fetch('APP_VERSION', '1.0.0'),
      ruby_version: RUBY_VERSION,
      environment: settings.environment,
      timestamp: Time.now.iso8601,
      uptime: Process.clock_gettime(Process::CLOCK_MONOTONIC)
    }

    logger.info "Health check requested: #{health_data[:status]}"
    health_data.to_json
  end

  # Error handling
  error 404 do
    logger.warn "404 Not Found: #{request.path}"
    content_type :json
    { error: 'Not Found', path: request.path }.to_json
  end

  error 500 do
    logger.error "500 Internal Server Error: #{request.path}"
    content_type :json
    { error: 'Internal Server Error' }.to_json
  end

  # Start the server
  run! if __FILE__ == $PROGRAM_NAME
end
