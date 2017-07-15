#!/bin/bash

docker run --rm -it \
      -v drupal_modules:/app/modules \
      -v drupal_profiles:/app/profiles \
      -v drupal_themes:/app/themes \
      -v drupal_keys:/app/keys \
      -v drupal_sites:/app/sites \
--entrypoint bash drush/drush "$@"

