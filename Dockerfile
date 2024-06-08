#Base Dockerfile for Dependencies
FROM node:lts-alpine3.17 as builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .