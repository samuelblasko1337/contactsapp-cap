# --- Base ---
FROM node:20-alpine AS base
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev
COPY . .

# --- Build deployer payload (gen/pg) ---
FROM base AS build
RUN npx cds build --production || true

# --- App image ---
FROM node:20-alpine AS app
WORKDIR /app
ENV NODE_ENV=production
COPY --from=base /app ./
EXPOSE 4004
CMD ["npm","start","--","--port","4004"]

# --- Deployer image (runs cds-deploy) ---
FROM node:20-alpine AS deployer
WORKDIR /deployer
ENV NODE_ENV=production
COPY --from=build /app/gen/pg ./
CMD ["npm","start"]
