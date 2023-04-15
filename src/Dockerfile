FROM node:19.0.0
WORKDIR /app
COPY src/package*.json ./
RUN npm install
COPY src/ .
EXPOSE 8080
CMD [ "npm", "start" ]