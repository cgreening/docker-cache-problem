FROM node

RUN mkdir /app
COPY . /app

WORKDIR /app
RUN yarn

ENTRYPOINT ["yarn", "start"]