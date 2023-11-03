# Stage 1. Install dependencies
FROM node:lts-alpine as install
COPY app/package*.json .
RUN npm i

# Stage 2. Build app
FROM node:lts-alpine as build
COPY --from=install ./node_modules ./node_modules
COPY app/ .
RUN npm run build

# Stage 3. Run app with busybox
FROM busybox:stable-musl
COPY --from=build ./build .
CMD ["busybox", "httpd", "-f", "-v", "-p", "3000"]