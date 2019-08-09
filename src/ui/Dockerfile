#atsip/ui            2.0                 dc30bd952773        4 minutes ago       269MB
FROM ruby:alpine
RUN apk add --update ruby-dev build-base

ENV APP_HOME /app
RUN mkdir $APP_HOME

WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
RUN bundle install
ADD . $APP_HOME

ENV POST_SERVICE_HOST newpost
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST newcomment
ENV COMMENT_SERVICE_PORT 9292

CMD ["puma"]
