FROM ruby:2.6.5

RUN apt-get update -qq && apt-get install -y build-essential

RUN apt-get install -y libpq-dev

RUN mkdir /author-list-challenge
WORKDIR /author-list-challenge

COPY Gemfile /author-list-challenge/Gemfile
COPY Gemfile.lock /author-list-challenge/Gemfile.lock

RUN bundle install

COPY . /author-list-challenge
