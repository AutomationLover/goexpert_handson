Ansible ad-hoc commands are a powerful yet simple way to perform quick tasks, especially during the development phase. Here are few examples:

1. **Ping all hosts:** 

    ```bash
    ansible all -m ping
    ```
    This command will run a ping task on all hosts in your inventory.

2. **Gather facts from all hosts:**

    ```bash
    ansible all -m setup
    ```
    This command will gather facts (system and setup information) about all of the servers you are managing.

3. **Manage packages using apt:**

    ```bash
    ansible all -b -m apt -a "name=nginx state=present"
    ```
    This command will make sure the nginx package is installed on all servers.

4. **Manage services with systemd module:**

    ```bash
    ansible all -m systemd -a "name=nginx state=started"
    ```
    Here `-b` or `--become` tells ansible to run operations with become (privilege escalation). or you can use " --become --become-method=sudo"
    This command will make sure the nginx service is started on all servers.

5. **Create a user on all servers:**

    ```bash
    ansible all -b -m user -a "name=testuser password={{ 'mysecretpassword' | password_hash('sha512') }}"
    ```
    This command will create a user 'testuser' with the specified password on all servers.

6. **Copy a file to all servers:**

    ```bash
    ansible all -m copy -a "src=/etc/hosts dest=/tmp/hosts"
    ```
    This command will copy the /etc/hosts file from your system to /tmp/hosts location on all the servers.

7. **Delete a file from all servers:**

    ```bash
    ansible all -m file -a "path=/tmp/sample.txt state=absent"
    ```
    This command will delete /tmp/sample.txt from all servers.

8. **Restart a service on all servers:**

    ```bash
    ansible all -m apt -a "name=nginx state=present"
    ```
    This command will restart the nginx service on all servers.

9. **Execute a command on all servers:**

    ```bash
    ansible all -m command -a "uptime"
    ```
    This command will run 'uptime' on all servers and return the result. 

Please replace `all` with your desired group or host in all above commands. Remember, you need to have a proper inventory file set up for these commands to work.


Official Docs for Ansible module
https://docs.ansible.com/ansible/latest/collections/index_module.html
