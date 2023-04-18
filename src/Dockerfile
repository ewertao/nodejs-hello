FROM node:19.0.0
WORKDIR /app
COPY src/package*.json /app/
RUN npm install
COPY src /app/
EXPOSE 8080
CMD [ "npm", "start" ]
