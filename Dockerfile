From ubuntu:trusty
MAINTAINER David Gilly 

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND noninteractive

# Update
RUN apt-get update

# Start editing
# Install package here for cache
RUN apt-get -y install supervisor postfix dovecot-common dovecot-imapd dovecot-pop3d

# Add files
ADD install.sh /
ADD create_user.sh /usr/local/bin/
ADD dovecot/10-auth.conf /etc/dovecot/conf.d/
ADD dovecot/10-master.conf /etc/dovecot/conf.d/
ADD dovecot/10-ssl.conf /etc/dovecot/conf.d/
ADD postfix/master.cf /etc/postfix/

EXPOSE 25 143 587 993 995 110 465
VOLUME ["/var/mail","/home"]

# Run
CMD /install.sh;/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
