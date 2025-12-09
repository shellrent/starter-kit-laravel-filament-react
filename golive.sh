#!/bin/bash

# Update dependencies
php composer.phar install --no-dev --optimize-autoloader --no-scripts

# Package discovery
php artisan package:discover --ansi
if [ $? != 0 ]; then
	printf "\n\nERROR! migrating\n\n"
	exit 1
fi

# Migrate the database
php artisan migrate --force
if [ $? != 0 ]; then
	printf "\n\nERROR! migrating\n\n"
	exit 1
fi

# Generate optimized class loader
php artisan optimize
if [ $? != 0 ]; then
	printf "\n\nERROR! optimizing\n\n"
	exit 1
fi

# Clear the cache
php artisan cache:clear
if [ $? != 0 ]; then
    printf "\n\nERROR! clearing cache\n\n"
    exit 1
fi

# Refresh the schedule
php artisan schedule:clear-cache

if [ $? != 0 ]; then
    printf "\n\nERROR! refreshing schedule\n\n"
    exit 1
fi

# Clear the config cache
php artisan config:clear
if [ $? != 0 ]; then
	printf "\n\nERROR! clearing config\n\n"
	exit 1
fi

php artisan config:cache
if [ $? != 0 ]; then
	printf "\n\nERROR! Chaching config\n\n"
	exit 1
fi

php artisan route:cache
if [ $? != 0 ]; then
	printf "\n\nERROR! Chaching route\n\n"
	exit 1
fi

php artisan view:cache
if [ $? != 0 ]; then
	printf "\n\nERROR! clearing view\n\n"
	exit 1
fi

# Clear filament cache
php artisan filament:optimize-clear
if [ $? != 0 ]; then
    printf "\n\nERROR! caching icons\n\n"
    exit 1
fi

# Cache filament components
php artisan filament:optimize
# alias for `php artisan filament:cache-components` and `php artisan icons:cache`
if [ $? != 0 ]; then
    printf "\n\nERROR! caching icons\n\n"
    exit 1
fi

# Restart the queue
php artisan queue:restart

if [ $? != 0 ]; then
	printf "\n\nERROR! restarting queue\n\n"
	exit 1
fi

node -v

yarn install
yarn build

printf "\n\n***** Backend deployed! *****\n"
