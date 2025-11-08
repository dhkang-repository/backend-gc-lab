
# backend-gc-lab

Quick lab to observe keep-alive and GC behavior on macOS.

## Quickstart

```bash
# 0) JDK 21 (macOS)
brew install openjdk@21
sudo ln -sfn $(brew --prefix openjdk@21)/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-21.jdk
export PATH="$(brew --prefix openjdk@21)/bin:$PATH"

# 1) Run server
./scripts/run.sh

# 2) In another terminal: watch GC
./scripts/jstat_watch.sh

# 3) In another terminal: install wrk and load
brew install wrk
./scripts/load.sh http://localhost:8080/ping 400 60s

# 4) Observe OU/OC rising when holding memory:
curl 'http://localhost:8080/alloc?sizeMb=50&hold=true'
curl 'http://localhost:8080/alloc?sizeMb=50&hold=true'
# watch OU increase; then clear:
curl 'http://localhost:8080/clear'
```

Endpoints:
- `/ping`      : small response (good for keep-alive throughput)
- `/stream`    : SSE stream (chunked demonstration)
- `/alloc`     : allocate memory: `?sizeMb=5&hold=true|false`
- `/clear`     : clear held references
