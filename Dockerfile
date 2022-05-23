FROM node:12.14.0 as node
FROM ruby:2.7.1

RUN apt-get update -qq && apt-get install -y postgresql-client && \
    apt-get install -y locales cron tzdata
RUN locale-gen ja_JP.UTF-8
RUN rm /etc/localtime \
  && ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
  && dpkg-reconfigure -f noninteractive tzdata

COPY --from=node /usr/local/bin/node /usr/local/bin/node
COPY --from=node /usr/local/include/node /usr/local/include/node
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
RUN ln -s /usr/local/bin/node /usr/local/bin/nodejs && \
    ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

ENV YARN_VERSION 1.21.1

COPY --from=node /opt/yarn-v$YARN_VERSION /opt/yarn
COPY --from=node /usr/local/bin/node /usr/local/bin/

RUN ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
    && ln -s /opt/yarn/bin/yarnpkg /usr/local/bin/yarnpkg

ENV BUNDLER_VERSION 2.1.3

RUN gem install bundler -v $BUNDLER_VERSION

RUN mkdir -p /var/www/
WORKDIR /var/www/

COPY ./docker/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
