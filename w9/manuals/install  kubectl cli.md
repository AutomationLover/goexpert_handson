To install `kubectl` on an Ubuntu EC2 instance, you can follow the steps below:

1. **Update the Apt package list**: 

First, you need to update your local package index. You can do this with the following command:

```bash
sudo apt-get update
```
2. **Install Curl**:

You may need to download `kubectl` using Curl. If you don't have Curl installed, you can install it using:

```bash
sudo apt-get install curl
```
3. **Download the latest release with the command**:

Download the latest stable release of `kubectl` using Curl:

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
```

This command uses Curl to download the latest stable version of `kubectl`. If you want to download a specific version, replace `$(curl -L -s https://dl.k8s.io/release/stable.txt)` with the specific version number.

4. **Make the kubectl binary executable**:

Once downloaded, you need to make the binary executable:

```bash
chmod +x ./kubectl
```
5. **Move the binary in to your PATH**:

Next, you'll want to move this binary into your PATH with the following command:

```bash
sudo mv ./kubectl /usr/local/bin/kubectl
```

6. **Test to ensure the version you installed is up-to-date**:

You can test to ensure that you've installed `kubectl` correctly by checking its version:

```bash
kubectl version --client
```

If `kubectl` is installed correctly, this command will display the version you installed. 

Note: The `kubectl` CLI tool interacts with the Kubernetes API Server, so you need a configured Kubernetes cluster to use it. If you don't have a Kubernetes cluster, you can create one with Minikube, or you can use a managed Kubernetes service like Amazon's EKS, Google's GKE, or Microsoft's AKS.