# Stage 1. Install dependencies
# Generate a "node_modules" folder with npm for the next stages
FROM node:lts-alpine as install
WORKDIR /app
COPY app/package*.json .
RUN npm i

# Stage 2. Build app
# Generate "build" folder for last stage
FROM node:lts-alpine as build
WORKDIR /app
COPY --from=install ./app ./
COPY app/public ./public
COPY app/src ./src
RUN npm run build

# Stage 3. Run app with busybox
# Publish the app with busybox httpd command ['-f': Do not daemonize, '-v': Verbose, '-p': Bind to ip:port]
FROM busybox:stable-musl
WORKDIR /app
COPY --from=build ./app/build ./
CMD ["httpd", "-f", "-v", "-p", "3000"]