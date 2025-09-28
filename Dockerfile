# Simple Dockerfile for Sample Tracking
FROM ruby:3.4.6-alpine

# Install system dependencies
RUN apk add --no-cache \
    build-base \
    make \
    git \
    curl

# Set working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy application files
COPY . .

# Expose port
EXPOSE 4567

# Start the application
CMD ["bundle", "exec", "ruby", "app.rb"]
