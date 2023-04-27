FROM node:18.16.0 as build
ARG REACT_APP_TG_API_ID
ARG REACT_APP_TG_API_HASH

ARG ENV

ARG TG_API_ID
ARG TG_API_HASH
ARG ADMIN_USERNAME      

ARG DB_PASSWORD

ARG API_JWT_SECRET
ARG FILES_JWT_SECRET

ARG DATABASE_URL

COPY yarn.lock .
COPY package.json .
COPY api/package.json api/package.json
COPY web/package.json web/package.json
#COPY docker/.env .
RUN yarn cache clean
RUN yarn install --network-timeout 1000000
COPY . .
RUN yarn workspaces run build
RUN yarn server prisma migrate deploy
