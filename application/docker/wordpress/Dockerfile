FROM wordpress:5.4.0-php7.3-fpm-alpine

WORKDIR /usr/local/bin/
# Install script to perform an health check
RUN apk add --no-cache fcgi \
    && curl -s -o php-fpm-hc \
    https://raw.githubusercontent.com/renatomefi/php-fpm-healthcheck/master/php-fpm-healthcheck \
    && chmod +x php-fpm-hc

WORKDIR /usr/src/wordpress

# remove useless files
RUN rm -rf \
	readme.html \
    install.sh \
    plugins.txt \
	wp-config-sample.php \
    themes.txt

# remove default plugins
RUN rm -rf \
    wp-content/plugins/akismet/ \
    wp-content/plugins/hello.php

# remove listen rule in order to manage the php conf from k8s configmaps
RUN sed -i -e '/listen/d' /usr/local/etc/php-fpm.d/zz-docker.conf

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]