FROM ruby:2.6.5-alpine AS builder

# Install bundler
RUN gem install bundler -v "~> 2.4.22"

# Install build dependencies
RUN apk add --no-cache \
      build-base \
      git \
      nodejs \
      yarn \
      postgresql-dev \
      sqlite-dev \
      tzdata \
      bash \
      linux-headers \
      libc-dev

# Set working directory
WORKDIR /app

# Copy Gemfile first (for layer caching)
COPY Gemfile Gemfile.lock ./

# Update websocket
RUN bundle update

# Install gems
RUN bundle install

# Copy rest of the app
COPY . .

FROM ruby:2.6.5-alpine

# Install dependencies
RUN apk add --no-cache \
      postgresql-libs \
      sqlite-libs \
      tzdata \
      nodejs \
      yarn \
      bash

WORKDIR /app

COPY --from=builder /usr/local/bundle /usr/local/bundle

COPY --from=builder /app /app

# Expose app port
EXPOSE 4567

# Default command to run the app
CMD ["ruby", "app.rb"]
