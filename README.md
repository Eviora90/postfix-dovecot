# postfix-dovecot
In testing …

Postfix and Dovecot imap with STARTTLS encryption.

## Run the container
 ```docker run -d -e maildomain=yourdomain.xyz -p 25:25 -p 465:465 -p 143:143 -p 993:993 –name postfix-dovecot daone/postfix-dovecot```

## Account creation
1. Install mkpasswd:
 ```apt-get install whois```

2. Generate encrypted password:
 ```mkpasswd your_password```

3. Create the user:
 ```docker exec postfix-dovecot useradd -m -G mail -p encrypted_password user```

## Data out of the container
 ```docker run -d -e maildomain=yourdomain.xyz -v /path_for_postfix_mail_delivery:/var/mail -v path_for_imap_storage:/home -p 25:25 -p 465:465 -p 143:143 -p 993:993 --name postfix-dovecot daone/postfix-dovecot```

## Use your own SSL certificate
Generate your certificate :
 http://wiki2.dovecot.org/SSL/CertificateCreation

Save certificate as ssl.crt and key as ssl.key.

Add -v path_to_your_certificate:/ssl to ```docker run``` command.

```docker exec postfix-dovecot ln -s /ssl/ssl.crt /etc/dovecot/dovecot.pem```

```docker exec postfix-dovecot ln -s /ssl/ssl.key /etc/dovecot/private/dovecot.pem```

```docker exec postfix-dovecot doveadm reload```


## Issues and solutions.
* Thunderbird failed to find the settings for your email account.

To check if OCSP is the cause of the trouble disable it temporarily and retry to connect to your server.

Preferences -> Advanced -> Certificates -> Validation -> Uncheck "Use the Online Certificate Status Protocol (OCSP) to confirm the current validity of certificates"

http://unix.stackexchange.com/questions/123367/thunderbird-fails-to-connect-to-dovecot-and-postfix

