
#!/usr/bin/env bash
set -euo pipefail

URL=${1:-http://localhost:8080/ping}
CONCURRENCY=${2:-200}
DURATION=${3:-30s}

if ! command -v wrk >/dev/null 2>&1; then
  echo "Please install wrk (brew install wrk)"; exit 1
fi

echo "Hitting $URL with c=$CONCURRENCY for $DURATION (keep-alive)"
wrk -t4 -c${CONCURRENCY} -d${DURATION} --timeout 5s $URL
