#!/usr/bin/env bash

set -e

### Defaults

clojure_version="1.9.0-alpha10"

### Command line

function print_usage {
    cat <<EOF
Usage: $0 [-v clojure_version] [-s socket_repl_port] [-j jvm_ARG] [-- args...]

Launches specified Clojure version (${clojure_version} by default).

Classpath is generated from Leiningen project.clj if it exists.
EOF
}

java_args=()

while getopts "hv:c:j:s:-" OPT; do
    case "$OPT" in
        v) clojure_version="$OPTARG" ;;
        s) socket_repl_port="$OPTARG" ;;
        j) java_args+=("$OPTARG") ;;
        -) break ;;
        h) print_usage; exit ;;
    esac
done

shift $(($OPTIND - 1))

### Download Clojure JAR from Maven repository

clojure_jar_path="$HOME/.m2/repository/org/clojure/clojure/$clojure_version/clojure-${clojure_version}.jar"

if [[ ! -e "${clojure_jar_path}" ]]; then
    mvn dependency:get \
        -DrepoId=sonatype \
        -DrepoUrl=https://oss.sonatype.org/content/repositories/public/ \
        -DgroupId=org.clojure \
        -DartifactId=clojure \
        "-Dversion=${clojure_version}"
fi

### Building the classpath

classpath="${clojure_jar_path}"

if [[ -e project.clj ]]; then
    if [[ project.clj -nt .classpath ]]; then
        lein classpath > .classpath
    fi
    classpath="$(cat .classpath)"
fi

### Building the command line

command_line="java -cp ${classpath} ${java_args[@]}"

if [[ -n "$socket_repl_port" ]]; then
    command_line+="-Dclojure.server.repl=\"{:port ${socket_repl_port} :accept clojure.core.server/repl :server-daemon false}\""
fi

command_line+=" clojure.main"

eval ${command_line} $@
