FROM drupalci/web-5.6

# Update composer.
RUN composer self-update

# Install composer global packages.
RUN composer global require drush/drush:8.1.2 decipher/dcir:dev-develop#5499129
ENV PATH "$HOME/.composer/vendor/bin:$PATH"

WORKDIR /var/www/html

# Download and install Drupal 7.
RUN drush dl drupal-7 --destination=/var/www/html --drupal-project-rename=drupal-7 -y
RUN cd drupal-7 && drush si --db-url=sqlite://sites/default/files/.ht.sqlite -y
RUN cd drupal-7 && drush en simpletest -y

# Download and install Drupal 8.
RUN drush dl drupal-8 --destination=/var/www/html --drupal-project-rename=drupal-8 -y
RUN cd drupal-8 && drush si --db-url=sqlite://sites/default/files/.ht.sqlite -y
RUN cd drupal-8 && drush en simpletest -y

# Setup volume for project.
VOLUME ["/dcir"]

# Set DCIR as the entrypoint.
ENTRYPOINT ["dcir"]