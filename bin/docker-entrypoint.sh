#!/usr/bin/env bash
set -Eeuo pipefail
export PGPASSWORD="${POSTGRES_PASSWORD:-postgres}"
until pg_isready -h "${POSTGRES_HOST:-db}" -p "${POSTGRES_PORT:-5432}" -U "${POSTGRES_USER:-postgres}" >/dev/null 2>&1; do
  sleep 1
done
bundle check || bundle install --jobs 4 --retry 3
bundle exec rails db:prepare
exec bundle exec rails s -b 0.0.0.0 -p 3000
