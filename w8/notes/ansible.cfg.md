ansible.cfg是Ansible配置文件的名称，这个文件用于定义Ansible的一些配置选项。例如，您可以在此文件中指定您的inventory（清单）文件的位置，定义私有密钥的位置，设置主机密钥检查，移除用户等等。这是一种强大的工具，可以帮助您自定义Ansible的运行方式以适应您的特定需求。

Ansible.cfg文件可以放置在多个位置。Ansible会按照以下顺序查找它：
1. 当前目录（./）
2. 主目录（~/）
3. /etc/ansible/ 目录

以下是一个典型的ansible.cfg文件的示例：

``` 
[defaults]
inventory = /path/to/your/inventory
private_key_file = /path/to/your/private/key
host_key_checking = False
remote_user = your_username
```

在此示例中，我们定义了inventory和private_key_file的路径，关闭了主机密钥检查，并设定了远程用户名。

您可以访问 [https://docs.ansible.com/ansible/latest/reference_appendices/config.html](https://docs.ansible.com/ansible/latest/reference_appendices/config.html) 查看完整的参考信息。
