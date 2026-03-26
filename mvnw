#!/bin/sh
# ----------------------------------------------------------------------------
# Maven Wrapper startup script, version 3.3.2
# ----------------------------------------------------------------------------

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
WRAPPER_JAR="$BASE_DIR/.mvn/wrapper/maven-wrapper.jar"
WRAPPER_PROPERTIES="$BASE_DIR/.mvn/wrapper/maven-wrapper.properties"

if [ ! -f "$WRAPPER_JAR" ]; then
  echo "Downloading Maven Wrapper..."
  WRAPPER_URL="$(grep -E '^wrapperUrl=' "$WRAPPER_PROPERTIES" | cut -d'=' -f2-)"
  mkdir -p "$(dirname "$WRAPPER_JAR")"
  curl -fsSL "$WRAPPER_URL" -o "$WRAPPER_JAR"
fi

exec java -classpath "$WRAPPER_JAR" -Dmaven.multiModuleProjectDirectory="$BASE_DIR" org.apache.maven.wrapper.MavenWrapperMain "$@"

