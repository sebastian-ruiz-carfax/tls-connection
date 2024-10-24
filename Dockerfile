FROM nginx:1.27.0-alpine
RUN apk update && apk upgrade --available && apk add --no-cache libxml2 curl
RUN apk add --no-cache  --update nodejs npm
RUN mkdir -p /home/node/app/node_modules
WORKDIR /home/node/app
COPY . .
COPY ./certs/ca.crt /certs/ca.crt
COPY ./certs/server.key /certs/server.key
COPY ./certs/server.crt /certs/server.crt
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
RUN npm install pm2 -g
RUN npm i
RUN npm run build
WORKDIR /home/node/app/dist
EXPOSE 443
COPY bash.sh .
CMD ["/bin/sh", "bash.sh"]

# - ./certs/ca.crt /certs/ca.crt
# - ./certs/server.key /certs/server.key
# - ./certs/server.crt /certs/server.crt
# - ./nginx/default.conf /etc/nginx/conf.d/default.conf
# - ./nginx/nginx.conf /etc/nginx/nginx.conf