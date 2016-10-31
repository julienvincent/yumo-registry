FROM node:6-slim
MAINTAINER Julien Vincent <julienlucvincent@gmail.com>

RUN adduser --disabled-password --gecos "" sinopia
RUN mkdir -p /opt/sinopia/storage

WORKDIR /opt/sinopia

RUN npm install js-yaml sinopia
RUN chown -R sinopia:sinopia /opt/sinopia

USER sinopia

ADD container/config.yml /tmp/config.yaml
ADD container/start.sh /opt/sinopia/start.sh

RUN rm -rf /opt/sinopia/node_modules/sinopia/lib/up-storage.js
ADD container/up-storage.js /opt/sinopia/node_modules/sinopia/lib/up-storage.js

CMD ["/opt/sinopia/start.sh"]
EXPOSE 4873
VOLUME /opt/sinopia