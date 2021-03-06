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
echo "alias yinfo='yarn info '" >> ~/.bashrc
echo "alias yinit='yarn init '" >> ~/.bashrc
echo '
yas () {
    yarn add $@ -S
}

yad () {
    yarn add $@ -D
}
' >> ~/.bashrc

echo "alias lgulp='./node_modules/.bin/gulp '" >> ~/.bashrc
echo "alias lwebpack='./node_modules/.bin/webpack '" >> ~/.bashrc

# Vagrant aliases
echo "alias vu='vagrant up'" >> ~/.bashrc
echo "alias vs='vagrant ssh'" >> ~/.bashrc
echo "alias vh='vagrant halt'" >> ~/.bashrc
echo "alias vp='vagrant provision'" >> ~/.bashrc

# Docker aliases
echo "alias dc='docker container'" >> ~/.bashrc
echo "alias di='docker image'" >> ~/.bashrc
echo "alias dr='docker run'" >> ~/.bashrc
echo "alias de='docker exec'" >> ~/.bashrc

# System aliases
echo "alias fcc='sudo fc-cache -fv'" >> ~/.bashrc
echo "alias pmg='sudo pacman-mirrors -g'" >> ~/.bashrc
echo "alias scm='sudo chmod'" >> ~/.bashrc
echo "alias sco='sudo chown'" >> ~/.bashrc

# Make composer installed lib bins globally available
echo 'export PATH="$HOME/.config/composer/vendor/bin:$PATH"' >> ~/.bashrc

# Ruby related things
echo "alias be='bundle exec '" >> ~/.bashrc
echo "alias rh='rbenv rehash'" >> ~/.bashrc
echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc

# rbenv initialization
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

# To open new terminal tabs in pwd
echo '. /etc/profile.d/vte.sh' >> ~/.bashrc



################################################################################
# SET UP GIT + OPENSSH
################################################################################

sudo pacman -S git openssh wget curl bash-completion --noconfirm

# Copy prepared global gitconfig
sudo cp ./src/git/gitconfig ~/.gitconfig
sudo chown $USER:users ~/.gitconfig
sudo chmod 644 ~/.gitconfig

# Basic global git config
# git config --global user.name "John Doe"
# git config --global user.email "johndoe@acme.com"

# Generate new / add existing ssh keys
# ssh-keygen -t rsa -b 4096 -C "johndoe@acme.com"
# ssh-add ~/.ssh/id_rsa_existing_key



################################################################################
# INSTALL MAIN APPS
################################################################################
sudo pacman -S \
bleachbit \
easytag \
file-roller \
jpegoptim \
mac \
meld \
nodejs \
npm \
optipng \
guake \
tmux \
tree \
xclip \
ripgrep \
--noconfirm

yaourt -S \
flacon \
google-chrome \
micro \
skypeforlinux-bin \
slack-desktop \
tixati \
yarn \
--noconfirm



################################################################################
# INSTALL THEMES, ICONS AND EXTENSIONS
################################################################################

sudo pacman -S \
arc-gtk-theme \
--noconfirm

yaourt -S \
adapta-gtk-theme \
adapta-backgrounds \
gnome-shell-extension-coverflow-alt-tab-git \
gnome-shell-extension-dash-to-panel-git \
gnome-shell-extension-mediaplayer-git \
gnome-shell-extension-nohotcorner-git \
gnome-shell-extension-put-window-git \
gnome-shell-extension-topicons-plus-git \
gtk-arc-flatabulous-theme-git \
paper-icon-theme-git \
la-capitaine-icon-theme-git \
--noconfirm



################################################################################
# INSTALL FONTS
################################################################################

sudo pacman -S \
adobe-source-code-pro-fonts \
otf-fira-mono \
ttf-croscore \
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
ttf-vista-fonts \
--noconfirm



################################################################################
# INSTALL IDEs + GIT GUIs
################################################################################

sudo pacman -S atom --noconfirm
yaourt -S gitkraken --noconfirm

# mkdir ~/Configuration
# git clone git@github.com:imrea/setup-atom.git ~/Configuration/setup-atom
# sudo chown $USER:$USER -R ~/Configuration/
# sudo chmod 700 -R ~/Configuration/



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
# INSTALL REDIS
################################################################################

sudo pacman -S redis --noconfirm
sudo systemctl start redis.service
sudo systemctl enable redis.service



################################################################################
# INSTALL MYSQL (MARIADB)
################################################################################

sudo pacman -S mariadb --noconfirm
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl start mariadb.service
sudo systemctl enable mariadb.service

# sudo mysql_secure_installation
# https://www.digitalocean.com/community/tutorials/how-to-create-a-new-user-and-grant-permissions-in-mysql

# If mysql root user had any password set...
# mysql -u root -p[secret_password]

mysql -u root -e "CREATE USER 'msuser'@'localhost' IDENTIFIED BY 'secret'"
mysql -u root -e "GRANT ALL PRIVILEGES ON * . * TO 'msuser'@'localhost'"
mysql -u root -e "FLUSH PRIVILEGES"



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
sudo mkdir /etc/nginx/sites-enabled

sudo chown root:root -R /etc/nginx/*
sudo chmod 644 -R /etc/nginx/*

# git clone https://github.com/perusio/nginx_ensite.git ../nginx_ensite
# cd ../nginx_ensite
# sudo make install


# For simplicity, these can be copied in the main nginx.conf
sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/adminer /etc/nginx/sites-enabled/adminer

echo -e "127.0.0.1\tadminer.local" | sudo tee --append /etc/hosts

sudo systemctl start nginx.service php-fpm.service
sudo systemctl enable nginx.service php-fpm.service



################################################################################
# INSTALL VIRTUALBOX
################################################################################

sudo pacman -S vagrant virtualbox virtualbox-host-modules-arch --noconfirm
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
# newgrp docker



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
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Super>Page_Down']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Super>Page_Up']"

# Fix inofity file watch limit error
echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/40-max-user-watches.conf && sudo sysctl --system

# Remove orphans (https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#Removing_unused_packages_.28orphans.29)
sudo pacman -Rns $(pacman -Qtdq)



################################################################################
# RESTORE DCONF SETTINGS
################################################################################

# Manually if needed, by running dconf_restore.sh
