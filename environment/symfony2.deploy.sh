#!/bin/sh
echo "Refreshing from origin/master"
git fetch --all
git reset --hard origin/master
#cat assets/environment/symfony.forcessl.append >> app/config/security.yml
echo "Removing cache"
rm -rf app/cache/prod* app/logs/prod*
echo "Refreshing router cache"
app/console router:dump-apache --env=prod --no-debug > app/apache.router.cache

