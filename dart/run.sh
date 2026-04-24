#!/bin/bash

set -e

docker build --no-cache -t dart-project6044:test .

docker run -p 6044:6044 dart-project6044:test

echo "✅ Done! App running at http://localhost:6044"