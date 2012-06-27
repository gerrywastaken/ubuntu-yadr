# INSTALLATION PROCEDURE


## Topics
Hint, search =Topic: to navigate in the text.

  - Minimal requirements for the project
  - The workspace
  - NEW MACHINE SETUP Using Ubuntu Linux 11.x
  - Files to watch
  - Using the "prod" environment (and refresh caching)

## =Topic: Minimal requirements for the project
===============================================

See "NEW MACHINE SETUP" for complete setup details.

These are the Minimalest stuff we need:

sudo apt-get install git-core php5-mysql mysql-server-5.1 php5 php5-sqlite \
                     libapache2-mod-php5 libdbd-sqlite3 php5 php5-sqlite \
                     php-apc php5-curl apache2-mpm-itk php5-intl php5-ldap \
                     rabbitmq-server erlang php


## =Topic: Coding Standards
===========================

These tools gives you access to helpers to Format the code, follow coding standards and
help with reformat the source to fit with the Symfony2 standard.

It also gives you access to tools such as:

* Code sniffing for syntax errors and recommendations  (`phpcs`)
* Reformatter of code (no worry about syntax, it reformats it nicely anyway) (`php-cs-fixer`)
* Detect mess in the code (`phpmd`) (TODO)

Follow those steps

    sudo pear update-channels
    sudo pear upgrade PEAR

    sudo pear install http_request2
    sudo pear install PHP_CodeSniffer
    sudo pear install doc.php.net/pman

    cd /usr/share/php/PHP/CodeSniffer/Standards
    sudo git clone git://github.com/opensky/Symfony2-coding-standard.git Symfony2
    sudo vi /usr/share/php/data/PHP_CodeSniffer/CodeSniffer.conf
    sudo  phpcs --config-set default_standard Symfony2
    
    ln -s ~/.yadr/php/php-cs-fixer /usr/bin/php-cs-fixer



## =Topic: SublimeText
======================
Here is a list of modules I found most usefull under SublimeText 2

To install

    sudo mkdir -p /opt/sublimetext
    sudo chown -R renoirb:users /opt/sublimetext

(Extract in `/opt/sublimetext` the content of the downloaded archive)

Add those packages following:

* Packge Control  http://wbond.net/sublime_packages/package_control
* In Sublime Text menu: Preferences > Package Settings > Package Controle > Settins - User
* Paste the content of .yadr/sublime-text-2-config/User/

    cat ~/.yadr/sublime-text-2/config/Packages/User/Package\ Control.sublime-settings



## =Topic: The workspace
========================

See "NEW MACHINE SETUP" for complete setup details.

    mkdir -p ~/workspace/clientName/

    cd ~/workspace/clientName/



IMPORTANT:
   If you use a different VM to develop and that somebody else
   could get access to your VM, See "=Topic: USE A DIFFERENT SSH KEY"


After cloning, and "=SubTopic: Submodule revisions", Continue:


Perk: To get easy access to your current project workspace, how about a small word
      of command like "current"

    ln -s ~/workspace/clientName/project ~/.current

    echo 'alias current="cd ~/.current/"' >> ~/.bash_aliases

See my notes on the "=Topic: Files to watch" and adjust with your favourites.


Continuing with normal installation:

    cp app/config/parameters.ini.dist app/config/parameters.ini

    app/console assets:install --symlink web/

To use database and intialize, See: `README.md`, at the subtopic
"=SubTopic: Drop the current database, and regenerate".


Now, time to install Web server.

See "=Topic: APACHE ENVIRONMENT"



## =Topic: USE A DIFFERENT SSH KEY
=================================

This is most usefull if you share resources. Nobody should know your ssh private
key (the non .pub file) You could be warned of a potential hijack of your rights
if you use that key everywhere to connect in a passwordless fashion. Anybody with
access to that key file could get in your identity.

That said. Here is how you can specify a specific key


On the machine your configuring, execute:

    ssh-keygen -t dsa -f ~/.ssh/specific_dsa

We will now add the Key

    cat ~/.ssh/specific_dsa.pub

Add it to your repository server (github,Gitorious,etc) SSH Public Keys configuration

Then, we will ask to use that generated key with you repository server, copy the content of the file:

    assets/environment/ssh.config.append

Into `~/.ssh/config` (create it if it doesn't exist)

Lastly, clone the project:

    cd ~/workspace/clientName/
    git clone ssh://YOURCONFIGUREDUSER@use.specific.key.host:29418/project.git project

REMEMBER: The part "use.specific.key.host" is actually an alias you specified in `~/.ssh/config`

See in details at: "=Topic: CLONING THE PROJECT"

NOTE:
   If you are using .yadr (see in ~/.yadr) look for the ".secrets" file that has
   all the variables for your git configuration.

    vi ~/.yadr/.secrets

   Adjust it to your repository server configuration, example:

    # Set your git user info
    export GIT_AUTHOR_NAME='Renoir Boulanger'
    export GIT_AUTHOR_EMAIL='hello@renoirboulanger.com'
    export GIT_COMMITTER_NAME='Renoir Boulanger'
    export GIT_COMMITTER_EMAIL='hello@renoirboulanger.com'

Resume at "=SubTopic: Submodule revisions".






## =Topic: NEW MACHINE SETUP Using Ubuntu Linux 11.x
===================================================

### =SubTopic: User creation
----------------------------

Add a user:

    adduser project

Adjust permissions:

    vigr

 1. Make sure project has group admin at the end of his line

    visudo

 2. Make sure %admin line is not commented

 3. Add after "Defaults env_reset" the following line

    Defaults env_keep = "http_proxy ftp_proxy"


### =SubTopic: System wide settings
-----------------------------------

Adjust system wide settings:

    sudo vi /etc/bash.bashrc

 2. Add at the end:

    export http_proxy="http://proxyhost:8080/"
    export ftp_proxy="http://proxyhost:8080/"

3. Firefox

  Start Firefox, then go to Edit > Preferences, and adjust settings accordingly.·

  If you need more details about it in the reference
  for GNOME desktop below.

   4. GNOME desktop

  See: http://ubuntuforums.org/showthread.php?t=1575

  Roughly, in terminal

      gksu gnome-network-properties



### =SubTopic: Update system
----------------------------

Update and install those packages

Note: Do not forget the ones in the minimum requirements, See: "=Topic: Minimal requirements for the project", then:

    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get install git-core freemind php5-curl php5-gd php5-imagick \
                php5-memcache php5-tidy php5-xdebug php5-xsl \
                php5-mysql mysql-server-5.1 libapache2-mod-php5 \
                libdbd-sqlite3 php5 php5-sqlite php5-mysql \
                php-pear php-apc php5-curl phpmyadmin screen \
                apache2-mpm-itk php5-intl meld sqlite phpunit \
                vim exuberant-ctags vim php5-curl curl rake memcached

If you want to modify CSS/Javascript

    sudo apt-get install -y g++ curl libssl-dev apache2-utils git-core
    mkdir -p ~/install
    git clone git://github.com/ry/node.git nodejs
    cd nodejs && ./configure
    make
    sudo make install

Adjust your user preferences:

Then, bootstrap the dependencies (listed in package.json)

    cd ~/workspace/clientName/project
    npm install --force

For reference in the package.json format, see: http://npmjs.org/doc/install.html


### =SubTopic: Optionnal, a set of shell scripts (aka. YADR)
------------------------------------------------------------

YADR: Yet An other Dotfile Repo

This is a dot file repository project, for Ubuntu, that I am maintaining. It 
provides auto-complete and code lint integrated in vim and some other stuff.

    git clone git://github.com/renoirb/ubuntu-yadr ~/.yadr

    cd ~/.yadr && rake install


Continue with Server parameters:


    sudo a2enmod ldap deflate rewrite


Then, See: "=Topic: APACHE ENVIRONMENT"



## =Topic: APACHE ENVIRONMENT
=============================

Depends of where you deploy.

The main difference would be mostly if we use *Magical* hostname and
some logging parameters.

See:
  * "=Topic: APACHE PRODUCTION ENVIRONMENT"
  * "=Topic: APACHE DEVELOPMENT ENVIRONMENT"



## =Topic: APACHE DEVELOPMENT ENVIRONMENT
=========================================

This variant makes use of *Magical* virtual host that will map
a domain name to a workspace.

    http://clientName.project.dev/

Will map to the correspondig workspace, as of this example, would map to:

    /home/project/workspace/clientName/project/


### The steps
-------------

Make sure you have a /etc/hosts entry  clientName.project.dev that points to 127.0.0.1

    sudo cat '127.0.0.1      clientName.project.dev' >> /etc/hosts

Configure ports, to add the feature configuration

    sudo a2enmod vhost_alias

    sudo vi /etc/apache2/ports.conf

Add this line:

    UseCanonicalName Off

Backup the original default file, and we will use a magic host file that will map workspace configuration.

    sudo mv /etc/apache2/sites-available/default /etc/apache2/sites-available/default.bak
    sudo vi /etc/apache2/sites-available/default

Add those lines, from that file:

   cat assets/environment/apache.dev.vhost.config


... Continue with "=Topic: PHP APPLICATION SERVER CONFIGURATION"



## =Topic: APACHE PRODUCTION ENVIRONMENT
========================================

The files are basically the same, except the fact that you may not want
to use the *Magical* virtual host.  And you may know the ServerName.

You can use this as a template for the production:

    cat assets/environment/apache.prod.vhost.config

Generate the routing cache, it will get included by the vhost config file.

    app/console router:dump-apache --env=prod > app/apache.router.cache

NOTE:
This is more explained in "=SubTopic: Caching and routing"


### =SubTopic: Port number
--------------------------

If you need to change the port `<VirtualHost *:80>` to something else, do not forget
to adjust it in the port.conf file.

    sudo vi /etc/apache2/ports.conf



### =SubTopic: Caching and routing
----------------------------------

Symfony2 provides a command that generates Apache configuration rewrite directives that you
can use for production.

See the output:

    app/console router:dump-apache --env=prod

Later in the DEPLOYING.md, we'll have it cached in a file and Included by Apache.

WARNING:
Make sure the `assets/environment/apache.prod.vhost.config` refers to the
project's `app/apache.router.cache` file.

Continue with "=Topic: PHP APPLICATION SERVER CONFIGURATION"



## =Topic: PHP APPLICATION SERVER CONFIGURATION
===============================================

Restart the server to apply the configuration (you could also do `reload` if it is in production)
    sudo service apache2 restart

Change some important defaults settings:

    sudo vi /etc/php5/apache2/php.ini

    ### code ###
    date.timezone = America/Montreal
    short_open_tag = Off
    ### /code ###

Always in the `php.ini`, adjust those mysql settings

    sudo vi /etc/mysql/my.cnf

Namely:
 1. Find mysqld.sock, see if it still fits with the app/config/parameters.ini
 2. Make sure [mysqld] block has collation_server and character_set_server setting
 3. Check whether log_bin is set for production (bacups, database play log if you want)

    ###  code ###
    # Make sure mysql talks only utf-8
    collation_server        = utf8_unicode_ci
    character_set_server    = utf8
    ### /code ###

Database:

    In most dev or staging machines, it is recommended to use default password for `root` to `root`.



## =Topic: Mini procedures remindersMySQL Database management
====================================

Every project i frequently use a specific user for the database, here is how I create and recreate databases and users




=SubTopic: Drop the current database, and regenerate
----------------------------------------------------

This is usefull to rebuild with the latest changes

    mysql -u root -p"root" --default-character-set=utf8
    mysql>  CREATE DATABASE `project_dev` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
    mysql>  quit;


### =SubTopic: Merging and deploying master
-------------------------------------------

#### On de development station

It is required because we do not necessarily want to have specific compilers
on the production environement. (such as sass, less, java, etc those are 
required for the asset compilation).

Merge with master first. This will also create ONE commit object concatenating
all previous log messages. Ideal for a release and the changelog.

    git checkout master
    git merge --no-ff --log develop

Create the tag, for future reference.

Adjust the `00` (at the end) with the day's sequencial number. If it's the first
of the day, leave 00. and add your own comment

    git tag -a b-`date "+%Y%m%d"00` -m "buildcomment"

Push to origin

    git push origin

    git push origin --tag

#### On the production machine

Fetch and get everything as it is on master:

    git fetch --all
    git reset --hard origin/master

Then do all cache clearing you may need.

#### On Symfony2 deployment


