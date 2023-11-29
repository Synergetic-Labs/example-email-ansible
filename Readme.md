The following is an example Ansible project as per https://synergeticlabs.com/email-alchemy/ to setup a mailserver with the following features:
- Dovecot (MDA)
- Postfix (MTA) 
- Rspamd (Spam filter)

To get started, create the vault and populate with key value pairs. 

`ansible-vault create inventory/group_vars/all.yml`
    
```
root_password: "generate-a-random-password" # system root password
user_password: "generate-a-random-password" # system user password
borg_passphrase: "generate-a-random-password" # backups password 
mailserver_password: "generate-a-random-password" # mailserver MariaDB password 
user_mail_password: "generate-a-random-password" # Test users password. 
```

- Update roles/base_os/files/users/user.pub with a public ssh key. 

