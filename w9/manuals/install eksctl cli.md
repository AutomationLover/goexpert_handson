Installing eksctl CLI on an Ubuntu EC2 instance involves a series of steps that are fairly simple and straightforward.

1. First and foremost, establish an SSH connection to your EC2 instance.

2. Update the installed packages and package list on your instance by using the following command:

```
sudo apt-get update
```

3. Download and extract the latest release of eksctl with the following command:

```
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
```

This command downloads the latest version of the eksctl CLI from the official GitHub repository and extracts the tarball into the /tmp directory.

4. Move the extracted binary to /usr/local/bin with this command:

```
sudo mv /tmp/eksctl /usr/local/bin
```

This command moves the eksctl binary to the /usr/local/bin directory, which is included in the system's PATH.