# image and default installs
FROM ruby:2.2.2
RUN apt-get update -qq && apt-get install -y build-essential

ENV APP_HOME /beatalong
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/

ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
  BUNDLE_JOBS=2 \
  BUNDLE_PATH=/bundle

RUN bundle install

ADD . $APP_HOME
