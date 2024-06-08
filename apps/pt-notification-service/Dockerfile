FROM my-base-image:nx as builder

RUN npx nx build pt-notification-service

FROM node:lts-alpine3.17 as Deps

WORKDIR /app
COPY --from=builder /app/dist/apps/pt-notification-service ./
COPY --from=builder /app/node_modules ./node_modules

CMD ["node", "./main.js"]