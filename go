#!/bin/bash

set -e
set -o nounset
set -o pipefail

SCRIPT_DIR=$(cd "$(dirname "$0")" ; pwd -P)

# shellcheck source=./go.helpers
source "${SCRIPT_DIR}/go.helpers"

goal_generate() {
  for file in tests/*.jsonnet; do
    jsonnet -J "$PWD" "${file}" > $file.golden
  done
}

goal_test() {
  prepare_tmp_folder
  EXECUTED=0
  FAILED=0

  for file in tests/*.jsonnet; do
    TEST_FILE="./tmp/$(basename "$file").json"
    FIXTURE="${file}.golden"

    jsonnet -J "$PWD" "${file}" > "$TEST_FILE"

    if ! cmp -s "$FIXTURE" "$TEST_FILE" ; then
      printf "\033[31;1mFAIL\033[0m \033[1m(comparison)\033[0m: \033[36m%s\033[0m\n" "$file"

      set +e
      git --no-pager diff --no-index "$FIXTURE" "$TEST_FILE"
      set -e

      FAILED=$((FAILED + 1))
    fi

    EXECUTED=$((EXECUTED + 1))
  done

  echo "$EXECUTED tests were run, $FAILED failed"
  if [ $FAILED -ne 0 ]; then
    exit 1;
  fi
}

goal_format() {
  for file in tests/*.jsonnet; do
    jsonnetfmt -i "${file}"
  done
}

validate-args() {
  acceptable_args="$(declare -F | sed -n "s/declare -f goal_//p" | tr '\n' ' ')"

  if [[ -z $1 ]]; then
    echo "usage: $0 <goal>"
    # shellcheck disable=SC2059
    printf "\n$(declare -F | sed -n "s/declare -f goal_/ - /p")"
    exit 1
  fi

  if [[ ! " $acceptable_args " =~ .*\ $1\ .* ]]; then
    echo "Invalid argument: $1"
    # shellcheck disable=SC2059
    printf "\n$(declare -F | sed -n "s/declare -f goal_/ - /p")"
    exit 1
  fi
}

CMD=${1:-}
shift || true
if validate-args "${CMD}"; then
  "goal_${CMD}"
  exit 0
fi
