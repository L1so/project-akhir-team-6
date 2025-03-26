FROM node:20 AS build

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build

FROM node:20-alpine AS production

WORKDIR /usr/src/app

COPY --from=build /usr/src/app .

RUN chmod +x /usr/src/app/wait.sh && npm install --only=production

EXPOSE 3001

CMD /usr/src/app/wait.sh -c 'echo > /dev/tcp/127.0.0.1/5432' && npm start
#CMD [ "npm", "start" ]
