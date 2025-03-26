FROM node:20 AS build

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY . .
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.7.3/wait /wait
RUN chmod +x /wait && npm run build

FROM node:20-alpine AS production

WORKDIR /usr/src/app

COPY --from=build /usr/src/app .

RUN npm install --only=production

EXPOSE 3001

CMD /wait && npm start
