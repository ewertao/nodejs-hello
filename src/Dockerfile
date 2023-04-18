FROM node:19.0.0
WORKDIR /app
COPY --from=build /scr/package*.json ./
RUN npm install
COPY --from=build /scr .
EXPOSE 8080
CMD [ "npm", "start" ]