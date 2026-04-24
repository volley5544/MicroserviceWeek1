# ---------- Stage 1: Test ----------
FROM node:20 AS tester

WORKDIR /app

COPY package*.json ./
RUN npm install --save-dev jest 
RUN npm ci

COPY . .

# Run tests (if fail → build stops here ❌)
RUN npm test

# ---------- Stage 2: Production ----------
FROM node:20-slim

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .

EXPOSE 5544

CMD ["npm", "start"]