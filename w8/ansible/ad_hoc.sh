# Rebooting servers
ansible all -a "sudo /sbin/reboot"

# Managing files
ansible tag_node -m copy -a "src=/etc/hosts dest=/tmp/hosts"

# Managing packages
ansible tag_node -m apt -a "name=zip state=present" --become --become-method=sudo
ansible tag_node -m apt -a "name=zip state=absent" --become --become-method=sudo
ansible tag_node -m apt -a "name=nginx state=present" --become --become-method=sudo

# Managing users
ansible tag_node -m user -a "name=foo" --become --become-method=sudo
ansible tag_node -m user -a "name=foo state=absent" --become --become-method=sudo

# Managing services
ansible tag_node -m service -a "name=nginx state=stopped" --become --become-method=sudo
ansible tag_node -m service -a "name=nginx state=started" --become --become-method=sudo
ansible tag_node -m service -a "name=nginx state=restarted" --become --become-method=sudo