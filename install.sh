#!/bin/bash

################################################################################
# SET UP BASHRC + GEMRC
################################################################################

# ls aliases
echo "alias ll='ls -l1h --group-directories-first'" >> ~/.bashrc
echo "alias lla='ls -l1ha --group-directories-first'" >> ~/.bashrc

# npm & yarn aliases
echo "alias nr='npm run '" >> ~/.bashrc
echo "alias yr='yarn run '" >> ~/.bashrc
echo "alias yadd='yarn add '" >> ~/.bashrc
echo "alias yinfo='yarn info '" >> ~/.bashrc
echo "alias yinit='yarn init '" >> ~/.bashrc
echo "alias lgulp='./node_modules/.bin/gulp '" >> ~/.bashrc
echo "alias lwebpack='./node_modules/.bin/webpack '" >> ~/.bashrc

# Vagrant aliases
echo "alias vu='vagrant up'" >> ~/.bashrc
echo "alias vs='vagrant ssh'" >> ~/.bashrc
echo "alias vh='vagrant halt'" >> ~/.bashrc
echo "alias vp='vagrant provision'" >> ~/.bashrc

# System aliases
echo "alias fcc='sudo fc-cache -fv'" >> ~/.bashrc
echo "alias pmg='sudo pacman-mirrors -g'" >> ~/.bashrc

# Make composer installed lib bins globally available
echo 'export PATH="$HOME/.config/composer/vendor/bin:$PATH"' >> ~/.bashrc

# Ruby related things
echo "alias be='bundle exec '" >> ~/.bashrc
echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc

# rbenv initialization
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

# To open new terminal tabs in pwd
echo '. /etc/profile.d/vte.sh' >> ~/.bashrc



################################################################################
# INSTALL MAIN APPS
################################################################################
sudo pacman -S \
jpegoptim \
meld \
nodejs \
npm \
optipng \
tree \
file-roller \
tmux \
tilda \
vlc \
--noconfirm

yaourt -S \
google-chrome \
slack-desktop \
tixati \
yarn \
--noconfirm



################################################################################
# INSTALL THEMES, ICONS AND EXTENSIONS
################################################################################

sudo pacman -S \
adapta-maia-theme \
arc-firefox-theme \
arc-firefox-theme-maia \
arc-gtk-theme \
arc-themes-maia \
--noconfirm

yaourt -S \
adapta-gtk-theme \
adapta-backgrounds \
chrome-gnome-shell-git \
gnome-shell-extension-coverflow-alt-tab-git \
gnome-shell-extension-dash-to-panel-git \
gnome-shell-extension-mediaplayer-git \
gnome-shell-extension-nohotcorner-git \
gnome-shell-extension-put-window-git \
gnome-shell-extension-topicons-plus-git \
gtk-arc-flatabulous-theme-git \
manjaro-backgrounds \
menda-circle-icon-theme \
paper-icon-theme-git \
la-capitaine-icon-theme-git \
--noconfirm



################################################################################
# INSTALL FONTS
################################################################################

sudo pacman -S \
adobe-source-code-pro-fonts \
otf-fira-mono \
otf-fira-sans \
ttf-hack \
ttf-inconsolata \
ttf-roboto \
ttf-ubuntu-font-family \
--noconfirm

yaourt -S \
office-code-pro \
otf-fira-code \
otf-hasklig \
ttf-fantasque-sans \
ttf-inconsolata-g \
ttf-monaco \
ttf-mononoki \
ttf-roboto-mono \
--noconfirm



################################################################################
# INSTALL IDEs + GIT GUIs
################################################################################

sudo pacman -S atom --noconfirm
yaourt -S gitkraken --noconfirm



################################################################################
# INSTALL RBENV + RUBY + GEMS
################################################################################

yaourt -S rbenv ruby-build --noconfirm

# Ruby 2.0.0, 2.1.4, 2.1.6, 2.1.7, 2.2.2, 2.2.3
# curl -fsSL https://gist.github.com/mislav/055441129184a1512bb5.txt | rbenv install --patch 2.0.0-p353

# Ruby 2.4.0
rbenv install 2.4.0
rbenv global 2.4.0
rbenv rehash

# gem install bundler rails jekyll sinatra thin
# rbenv rehash



################################################################################
# INSTALL POSTGRESQL
################################################################################

sudo pacman -S postgresql --noconfirm
sudo -i -u postgres initdb --locale $LANG -E UTF8 -D '/var/lib/postgres/data'
sudo systemctl start postgresql.service
sudo systemctl enable postgresql.service
sudo -i -u postgres createuser -s $USER
createdb $USER



################################################################################
# INSTALL MYSQL (MARIADB)
################################################################################

sudo pacman -S mariadb --noconfirm
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl start mariadb.service
sudo systemctl enable mariadb.service

# sudo mysql_secure_installation
# https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql

# If mysql user had any password set...
# mysql -u root -p[secret_password]
mysql -u root
# CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'mysqluser'@'localhost' IDENTIFIED BY 'secret';
GRANT ALL PRIVILEGES ON * . * TO 'mysqluser'@'localhost';
FLUSH PRIVILEGES;
\q



################################################################################
# INSTALL PHP + XDEBUG + PHP_CODESNIFFER (PHPCS,PHPCBF) + PHP-CS-FIXER
# SET UP GLOBAL LARAVEL + SYMFONY INSTALLERS
################################################################################

sudo pacman -S \
php \
xdebug \
composer \
php-fpm \
php-pgsql \
php-sqlite \
--noconfirm

yaourt -S php-pear --noconfirm

# For mongodb extension
sudo pecl install mongodb

# PostgreSQL extension
echo "extension=pgsql.so" | sudo tee --append /etc/php/php.ini
# MongoDB extension
echo "extension=mongodb.so" | sudo tee --append /etc/php/php.ini
# SQLite extensions
echo "extension=pdo_sqlite.so" | sudo tee --append /etc/php/php.ini
echo "extension=sqlite3.so" | sudo tee --append /etc/php/php.ini
# MySQL extension
echo "extension=mysqli.so" | sudo tee --append /etc/php/php.ini

composer global require "laravel/installer"
composer global require "squizlabs/php_codesniffer=*"
composer global require "friendsofphp/php-cs-fixer"
composer global require "phpunit/phpunit"
composer global require "phpmd/phpmd"

# Make these globally available despite Composer bin is already in $PATH
sudo ln -s /home/$USER/.config/composer/vendor/bin/laravel /usr/bin/laravel
sudo ln -s /home/$USER/.config/composer/vendor/bin/phpcs /usr/bin/phpcs
sudo ln -s /home/$USER/.config/composer/vendor/bin/phpcbf /usr/bin/phpcbf
sudo ln -s /home/$USER/.config/composer/vendor/bin/php-cs-fixer /usr/bin/php-cs-fixer
sudo ln -s /home/$USER/.config/composer/vendor/bin/phpunit /usr/bin/phpunit
sudo ln -s /home/$USER/.config/composer/vendor/bin/phpmd /usr/bin/phpmd

sudo curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
sudo chmod a+x /usr/local/bin/symfony



################################################################################
# INSTALL NGINX + ADMINER
################################################################################

sudo pacman -S nginx-mainline --noconfirm
yaourt -S adminer --noconfirm

sudo cp -Rf ./src/nginx/* /etc/nginx/
sudo mkdir /etc/nginx/servers-enabled

sudo chown root:root -R /etc/nginx/*
sudo chmod 644 -R /etc/nginx/*

# For simplicity, copied these in the main nginx.conf
# sudo ln -s /etc/nginx/servers-available/default /etc/nginx/servers-enabled/default
# sudo ln -s /etc/nginx/servers-available/adminer /etc/nginx/servers-enabled/adminer

echo -e "127.0.0.1\tadminer.local" | sudo tee --append /etc/hosts

sudo systemctl start nginx.service php-fpm.service
sudo systemctl enable nginx.service php-fpm.service



################################################################################
# INSTALL VIRTUALBOX
################################################################################

sudo pacman -S vagrant virtualbox linux44-virtualbox-host-modules --noconfirm
sudo modprobe vboxdrv
sudo modprobe vboxnetadp
sudo modprobe vboxnetflt
sudo modprobe vboxpci
sudo gpasswd -a $USER vboxusers



################################################################################
# INSTALL DOCKER
################################################################################

sudo pacman -S docker docker-compose docker-machine --noconfirm
sudo systemctl start docker
sudo systemctl enable docker

# Add user to `docker` group and make session aware of this
sudo gpasswd -a $USER docker
newgrp docker



################################################################################
# REPLACE LIGHTDM WITH GDM
################################################################################

sudo pacman -S gdm --noconfirm
sudo systemctl disable lightdm
sudo systemctl enable gdm -f



################################################################################
# MISCELLANEOUS
################################################################################

# Fix multi-monitor workplace scroll
gsettings set org.gnome.shell.overrides workspaces-only-on-primary false

# Fix inofity file watch limit error
echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/40-max-user-watches.conf && sudo sysctl --system



################################################################################
# RESTORE DCONF SETTINGS
################################################################################

# Manually if needed, by running dconf_restore.sh
