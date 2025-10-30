# ---- Base: alles (inkl. dev) installieren ----
FROM node:20-alpine AS base
WORKDIR /app
COPY package*.json ./
# dev-Dependencies (cds-dk) mitinstallieren, damit 'cds' verfügbar ist
RUN npm ci
COPY . .

# ---- App-Image: nur prod deps, startet CAP ----
FROM node:20-alpine AS app
WORKDIR /app
ENV NODE_ENV=production
COPY --from=base /app ./
# dev-Dependencies wieder entfernen -> kleineres Runtime-Image
RUN npm prune --omit=dev
EXPOSE 4004
CMD ["npm","start","--","--port","4004"]

# ---- Deployer-Image: führt einmalig 'cds deploy' aus ----
FROM node:20-alpine AS deployer
WORKDIR /app
# komplette App inkl. cds-dk übernehmen
COPY --from=base /app ./
# wichtig: cds-dk ist da, daher funktioniert 'npx cds deploy'
CMD ["npx","cds","deploy","--to","postgres"]
