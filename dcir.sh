#!/usr/bin/env bash

# Ensure YAML configuration file exists.s 
CONFIG_FILE="/module/.dcir.yml"
if [ ! -f $CONFIG_FILE ]; then
  exit 1
fi

# Parse YAML configuration file.
. /dcir/includes/parse_yaml.sh
eval $(parse_yaml $CONFIG_FILE)

# Run Drush webserver.
drush runserver "http://127.0.0.1:8080" > /dev/null 2>&1 &

# Run simpletests.
php core/scripts/run-tests.sh --php /opt/phpenv/shims/php --verbose --color --concurrency 4 --url http://127.0.0.1:8080 "$simpletest_group"