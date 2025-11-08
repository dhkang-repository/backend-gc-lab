
#!/usr/bin/env bash
set -euo pipefail

PID=$(jps -l | awk '/gclab|BackendGcLabApplication/{print $1; exit}')
if [ -z "$PID" ]; then
  echo "PID not found. Is the app running?"; exit 1
fi

echo "Watching GC for PID=$PID"
jstat -gc -t $PID 1s
