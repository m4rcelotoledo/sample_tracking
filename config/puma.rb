# frozen_string_literal: true

# Puma configuration for Sample Tracking
# Optimized for production use

# Thread pool settings
threads_count = ENV.fetch('RAILS_MAX_THREADS', 5).to_i
threads threads_count, threads_count

# Worker processes
workers ENV.fetch('WEB_CONCURRENCY', 2).to_i

# Preload the application for better performance
preload_app!

# Port and host
port ENV.fetch('PORT', 4567).to_i
bind "tcp://#{ENV.fetch('HOST', '0.0.0.0')}:#{ENV.fetch('PORT', 4567)}"

# Environment
environment ENV.fetch('RACK_ENV', 'production')

# Logging
stdout_redirect '/dev/stdout', '/dev/stderr', true

# Process management
pidfile '/tmp/puma.pid'
state_path '/tmp/puma.state'

# Worker timeout
worker_timeout 30.seconds

# Worker boot
on_worker_boot do
  # Worker specific setup
end

# Master process
on_worker_fork do
  # Master process setup
end

# Shutdown
on_restart do
  # Restart handling
end
