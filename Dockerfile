FROM ruby:2.6.5
RUN apt-get update && apt-get install -y default-mysql-client

# install phantomjs
ENV OPENSSL_CONF=/etc/ssl/
RUN mkdir /tmp/phantomjs                                                                             && \
    curl -fsSL https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2   | \
        tar -xj --strip-components=1 -C /tmp/phantomjs                                               && \
    mv /tmp/phantomjs/bin/phantomjs /usr/local/bin/

WORKDIR /otwa
COPY Gemfile .
COPY Gemfile.lock .
RUN gem install bundler -v 1.17.3 && bundle install

COPY . .
EXPOSE 3000
CMD bundle exec rails s -p 3000
