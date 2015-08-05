From ubuntu:trusty
MAINTAINER David Gilly 

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive

# Update
RUN apt-get update

# Start editing
# Install package here for cache
RUN apt-get -y install supervisor postfix dovecot-common dovecot-imapd

# Add files
ADD install.sh /install.sh

# Run
CMD /install.sh;/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
