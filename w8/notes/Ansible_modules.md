Here are some popular Ansible modules and examples of how they can be used:

1. **command module**: This module takes the command and executes it on the host. Unlike the shell module, it does not process shell commands.

   Example:
   ```
   - name: Execute a command
     command: ls /var/log
   ```

2. **shell module**: Similar to the command module but it allows shell commands to be run. 

   Example:
   ```
   - name: Run a shell command
     shell: echo "Hello, World"
   ```

3. **copy module**: This module copies a file from the local or remote machine to a location on the remote machine. 

   Example:
   ```
   - name: Copy a file
     copy: 
       src: /etc/hosts
       dest: /tmp/hosts
   ```

4. **file module**: This module manages file properties and can also be used to create or remove files and directories.

   Example:
   ```
   - name: Change file ownership, group and permissions
     file:
       path: /etc/foo.conf
       owner: foo
       group: foo
       mode: '0644'
   ```

5. **yum module**: This module manages packages with the `yum` package manager, used in Red Hat-based systems.

   Example:
   ```
   - name: Install a package
     yum:
       name: git
       state: present
   ```

6. **apt module**: Like the `yum` module, but for Debian-based systems that use `apt` for package management.

   Example:
   ```
   - name: Install a package
     apt:
       name: git
       state: present
   ```

7. **service module**: This module manages services, allowing you to start, stop, restart, and reload services.

   Example:
   ```
   - name: Start service
     service:
       name: httpd
       state: started
   ```

8. **user module**: This module manages user accounts.

   Example:
   ```
   - name: Add a user
     user:
       name: john
       password: 'p@ssw0rd'
       state: present
   ```

9. **fetch module**: This module fetches a file from remote nodes.

   Example:
   ```
   - name: Fetch a file
     fetch:
       src: /remote/path/to/file
       dest:/local/path/to/file
       flat: yes
   ```

10. **template module**: This module templates a file out to a remote server.

   Example:
   ```
   - name: Template a file
     template:
       src: /path/to/local/template.j2
       dest: /path/on/remote/server
   ```
   `/path/to/local/template.j2` might look something like this:
   
   ```
   server {
       listen 80;
       server_name {{ server_name }};
       
       location / {
           root /var/www/{{ server_name }};
           index index.html;
       }
   }
   ```

You can find the comprehensive list of all available Ansible modules in the official Ansible documentation. Here's the web address:

https://docs.ansible.com/ansible/latest/collections/index_module.html

This page provides a list of all modules grouped by their collection. A collection in Ansible parlance is a distribution format for delivering all types of Ansible content. Click on any module to get detailed information about its usage, parameters, and examples.
