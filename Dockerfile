FROM node:20 AS build

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build

FROM node:20-alpine AS production

WORKDIR /usr/src/app

COPY --from=build /usr/src/app .

RUN apk add --no-cache wait4x && npm install --only=production

EXPOSE 3001

CMD wait4x tcp db:5432 && npm start
#CMD [ "npm", "start" ]
