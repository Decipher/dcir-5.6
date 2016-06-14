#!/usr/bin/php
<?php

use Symfony\Component\Yaml\Yaml;

require __DIR__ . '/vendor/autoload.php';

$config_file = '/module/.dcir.yml';
if (!file_exists($config_file)) {
  return;
}

// Parse yaml configuration.
$config = Yaml::parse(file_get_contents($config_file));

// Run Drush webserver.
passthru('drush runserver "http://127.0.0.1:8080" > /dev/null 2>&1 &');

// Run simpletests.
passthru('php core/scripts/run-tests.sh --php /opt/phpenv/shims/php --verbose --color --concurrency 4 --url http://127.0.0.1:8080 "' . $config['simpletest_group'] . '"');