FROM node:19.0.0
WORKDIR /app
COPY scr/package*.json ./
RUN npm install
COPY scr .
EXPOSE 8080
CMD [ "npm", "start" ]