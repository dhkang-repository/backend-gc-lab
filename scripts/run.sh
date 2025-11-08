
#!/usr/bin/env bash
set -euo pipefail

JVM_OPTS=(
  "-XX:+AlwaysActAsServerClassMachine"
  "-XX:+UseG1GC"
  "-XX:MaxGCPauseMillis=100"
  "-Xms512m"
  "-Xmx512m"
  "-XX:+HeapDumpOnOutOfMemoryError"
  "-XX:HeapDumpPath=./heapdump.hprof"
)

./gradlew -q bootRun --args='--spring.main.banner-mode=off'   --no-daemon   -Dorg.gradle.jvmargs="-Xmx1g"   -Dspring.output.ansi.enabled=ALWAYS   -Dlogging.config=classpath:log4j2.xml   -Dspring.jmx.enabled=false   -Dspring.main.lazy-initialization=true   -Dspring.main.allow-bean-definition-overriding=true   -Dspring.main.banner-mode=off   -Dserver.shutdown=graceful   -Dspring.lifecycle.timeout-per-shutdown-phase=10s   -Dspring.profiles.active=dev   -Dspring.task.scheduling.pool.size=4   -Dspring.threads.virtual.enabled=true   -Djava.library.path=.   -Dreactor.netty.pool.leasingStrategy=lifo   -Dreactor.netty.pool.maxConnections=1000   -Dreactor.netty.pool.maxIdleTime=60s   -Dreactor.netty.pool.acquireTimeout=15s   -Dreactor.netty.http.server.accessLogEnabled=false   -Dserver.tomcat.keep-alive-timeout=60000   -Dserver.tomcat.max-keep-alive-requests=10000   -Dserver.tomcat.max-connections=20000   -Dserver.tomcat.threads.max=200   -Dserver.tomcat.connection-timeout=5s   -Dlogging.level.root=INFO   -Dspring.devtools.restart.enabled=false   -D"JAVA_TOOL_OPTIONS=${' '.join(JVM_OPTS)}"
