FROM node:20 AS build

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build

FROM node:20-alpine AS production

WORKDIR /usr/src/app

COPY --from=build /usr/src/app .

RUN apk add --no-cache bash && npm install --only=production && chmod +x /usr/src/app/wait-for-it.sh

EXPOSE 3001

#CMD ["sh", "-c", "/usr/local/bin/wait-for-it.sh postgres:5432 -- npm start"]
CMD [ "npm", "start" ]
