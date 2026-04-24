#!/bin/bash

set -e

docker build -t java-app3579:test .

docker run -p 3579:3579 java-app3579:test

echo "✅ Done! App running at http://localhost:3579"