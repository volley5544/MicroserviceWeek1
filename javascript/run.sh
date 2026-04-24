#!/bin/bash

# Stop script if any command fails
set -e

echo "🔨 Building Docker image..."
docker build -t my-node-app5544:test .

echo "🧹 Removing old container (if exists)..."
docker rm -f my-node-app5544 2>/dev/null || true

echo "🚀 Running container..."
docker run -d \
  -p 5544:5544 \
  --name my-node-app5544 \
  my-node-app5544:test

echo "✅ Done! App running at http://localhost:5544"