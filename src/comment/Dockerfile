#atsip/comment       2.0                 697fbb0c5eb4        2 minutes ago       267MB
FROM ruby:alpine
RUN apk add --no-cache --update build-base ruby-bundler ruby-dev

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install
ADD . $APP_HOME

ENV COMMENT_DATABASE_HOST comment_db
ENV COMMENT_DATABASE comments

CMD ["puma"]
