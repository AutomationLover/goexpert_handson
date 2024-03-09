Ansible Vault is a feature of Ansible that allows you to keep sensitive data such as passwords or keys in encrypted files, rather than as plaintext in your playbooks or roles. 

Here's an example of how to create a new encrypted file using Ansible Vault:

```bash
ansible-vault create secret.yml
```

When you run this command, Ansible Vault will ask you to enter a password. This password will be used to encrypt the file. After entering the password, you will be put into a text editor where you can define your variables:

```yaml
---
db_password: mysecretpassword
api_key: mysecretapikey
```

Once you save and exit, `secret.yml` will be encrypted with the password you entered.

To edit the encrypted file, use the `edit` command:

```bash
ansible-vault edit secret.yml
```

You will be asked for the password before you can edit the file.

To use variables from the encrypted file in a playbook, use the `include_vars` module:

```yaml
---
- hosts: localhost
  tasks:
    - name: Include variables from an encrypted file
      include_vars:
        file: secret.yml
        name: secret
```

To run a playbook that includes an encrypted file, use the `--ask-vault-pass` option:

```bash
ansible-playbook --ask-vault-pass playbook.yml
```

You will be asked for the password before the playbook runs.

For automated systems where manual password entry isn't feasible, you can also use a password file. The file should be secured and contain only your password in plaintext:

```bash
echo "mypassword" > .vault_password_file
```

And to use it:

```bash
ansible-playbook --vault-password-file .vault_password_file playbook.yml
```

This is just a basic introduction. Ansible Vault has many more features and options that provide great flexibility in managing your sensitive data.
