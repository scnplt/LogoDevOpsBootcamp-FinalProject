# Stage 1. Install dependencies
FROM node:14-alpine as install
WORKDIR /app
COPY app/package*.json .
RUN npm i

# Stage 2. Build app
FROM node:14-alpine as build
WORKDIR /app
COPY --from=install /app/node_modules ./node_modules
COPY app/ .
RUN npm run build

# Stage 3. Run
FROM node:14-alpine
WORKDIR /app
COPY --from=build /app/build ./build
RUN npm install -g serve
CMD ["serve", "-s", "build", "-l", "3000"]