# Open Monitoring Distribution
## Version: 0.1
FROM debian:jessie
MAINTAINER Stefan Schueller "sschueller@techdroid.com"

ENV DEBIAN_FRONTEND noninteractive

# Make sure package repository is up to date
RUN apt-get update
RUN apt-get upgrade -y

RUN gpg --keyserver keys.gnupg.net --recv-keys F8C1CA08A57B9ED7
RUN gpg --armor --export F8C1CA08A57B9ED7 | apt-key add -

# Add OMD source
#RUN echo 'deb http://labs.consol.de/repo/stable/debian jessie main' >> /etc/apt/sources.list
#RUN apt-get update

#RUN apt-get install -y libpython2.7 locales tzdata wget gdebi-core net-tools postfix time traceroute curl dialog dnsutils fping graphviz libapache2-mod-fcgid libdbi-dev libboost-program-options1.55.0 

RUN apt-get install -y libpython2.7 locales tzdata wget gdebi-core net-tools postfix

RUN wget http://files.omdistro.org/nightly/1.31.20160426/omd-1.31.20160426.jessie.amd64.deb
RUN gdebi -n omd-1.31.20160426.jessie.amd64.deb
RUN apt-get -f -y install

#Set timezone
RUN echo "Europe/Zurich" > /etc/timezone; dpkg-reconfigure tzdata

#Set locale
#RUN export LANGUAGE=en_US.UTF-8; export LANG=en_US.UTF-8; export LC_ALL=en_US.UTF-8; locale-gen en_US.UTF-8; dpkg-reconfigure locales

#RUN mkdir -p /omd/sites/

# Set up a default site
RUN omd create default

# We don't want TMPFS as it requires higher privileges
RUN omd config default set TMPFS off

# Accept connections on any IP address, since we get a random one
RUN omd config default set APACHE_TCP_ADDR 0.0.0.0

# Add watchdog script
ADD watchdog.sh /opt/omd/watchdog.sh
RUN chmod +x /opt/omd/watchdog.sh

# Set up runtime options
EXPOSE 80 5000

#RUN omd start

ENTRYPOINT ["/opt/omd/watchdog.sh"]
#ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]


