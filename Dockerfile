FROM drupalci/web-5.6

# Update computer and install Drush.
RUN composer self-update
RUN composer global require drush/drush:8.1.2
ENV PATH "$HOME/.composer/vendor/bin:$PATH"

# Download and install Drupal.
RUN drush dl drupal-8 --destination=/var/www --drupal-project-rename=html -y
WORKDIR /var/www/html
RUN drush si --db-url=sqlite://sites/all/files/ht.sqlite -y
RUN drush en simpletest -y

# Setup
RUN mkdir /module && ln -s /module /var/www/html/modules/local
VOLUME ["/module"]
ENTRYPOINT ["/module/tests/docker/entrypoint"]