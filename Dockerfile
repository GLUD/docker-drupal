FROM drupal:latest
LABEL mantainer "Sebastian Tabares Amaya <sytabaresa@gmail.com>"

RUN apt-get update && apt-get install -y libcurl4-gnutls-dev postgresql-client && docker-php-ext-install curl && docker-php-ext-enable curl

ENV COMPOSER_VERSION 1.4.2
RUN curl -s -f -L -o /tmp/installer.php https://raw.githubusercontent.com/composer/getcomposer.org/da290238de6d63faace0343efbdd5aa9354332c5/web/installer \
 && php -r " \
    \$signature = '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410'; \
    \$hash = hash('SHA384', file_get_contents('/tmp/installer.php')); \
    if (!hash_equals(\$signature, \$hash)) { \
        unlink('/tmp/installer.php'); \
        echo 'Integrity check failed, installer is either corrupt or worse.' . PHP_EOL; \
        exit(1); \
    }" \
 && php /tmp/installer.php --no-ansi --install-dir=/usr/bin --filename=composer --version=${COMPOSER_VERSION} \
 && rm /tmp/installer.php \
 && composer --ansi --version --no-interaction

#COPY ./composer.json ./composer.json
#RUN pwd && composer install
RUN composer require drush/drush && ln -s $(pwd)/vendor/bin/drush /usr/local/bin/drush


