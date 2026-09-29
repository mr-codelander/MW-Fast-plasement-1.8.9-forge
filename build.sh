#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

if ! command -v java >/dev/null 2>&1; then
  echo "Java not found. Rebuild the Codespace container."
  exit 1
fi

echo "Java version:"
java -version

JAVA_MAJOR=$(java -version 2>&1 | sed -n 's/.*version "\([0-9]*\).*/\1/p' | head -1)
if [ "$JAVA_MAJOR" != "1" ]; then
  echo "ERROR: This project requires Java 8."
  exit 1
fi

GRADLE_VERSION=2.14.1
GRADLE_DIR=".gradle-dist/gradle-${GRADLE_VERSION}"
GRADLE_ZIP=".gradle-dist/gradle-${GRADLE_VERSION}-bin.zip"

if [ ! -x "$GRADLE_DIR/bin/gradle" ]; then
  mkdir -p .gradle-dist
  if [ ! -f "$GRADLE_ZIP" ]; then
    echo "Downloading Gradle ${GRADLE_VERSION}..."
    curl -fL "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -o "$GRADLE_ZIP"
  fi
  rm -rf "$GRADLE_DIR"
  unzip -q "$GRADLE_ZIP" -d .gradle-dist
fi

echo "Building FastPlace..."
"$GRADLE_DIR/bin/gradle" --no-daemon build

echo
echo "BUILD SUCCESSFUL"
ls -lh build/libs/*.jar
