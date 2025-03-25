FROM node:20 AS build

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install  

COPY . .

RUN npm run build

FROM node:20-alpine AS production

WORKDIR /usr/src/app

COPY --from=build /usr/src/app .

RUN npm install --only=production  

EXPOSE 3001

CMD [ "npm", "start" ]
