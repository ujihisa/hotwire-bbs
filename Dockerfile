FROM ruby:3.0.0

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN env SECRET_KEY_BASE=`bin/rake secret` bin/rake assets:precompile

EXPOSE 8080

# tmp/pids/server.pid is just for docker-compose
CMD \
      rm -f tmp/pids/server.pid &&\
      bundle exec bin/rails server --binding 0.0.0.0
