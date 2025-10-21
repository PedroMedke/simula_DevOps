FROM node:18-alpine


WORKDIR /app


COPY package*.json ./
RUN apk add --no-cache python3 make g++ \
    && npm cache clean --force \
    && npm ci --production \
    && apk del python3 make g++

COPY . .


EXPOSE 3000


ENV NODE_ENV=production


CMD ["node", "src/index.js"]