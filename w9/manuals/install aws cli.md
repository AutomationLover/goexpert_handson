To install AWS CLI on Ubuntu EC2 instance, follow the steps below:

**Step 1: Update Your System**

First, make sure your Ubuntu system is up-to-date. You can do this by running the following commands:

```bash
sudo apt-get update
sudo apt-get upgrade
```
**Step 2: Install Unzip**

AWS CLI is distributed in a zip format. If you haven’t installed Unzip, you can install it using the following command:

```bash
sudo apt-get install unzip
```

**Step 3: Download AWS CLI Bundle**

You can download the AWS CLI Bundle using the following command:

```bash
curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
```
Next, unzip the downloaded package:

```bash
unzip awscliv2.zip
```

**Step 4: Install AWS CLI**

After unzipping the package, you can install AWS CLI using the following command:

```bash
sudo ./aws/install
```
After the installation is complete, you can verify the AWS CLI version by running:

```bash
aws --version
```
This will display the version of the AWS CLI installed on your system.

**Step 5: Configuring AWS CLI**

After installing, you need to configure AWS CLI with your credentials. You can do this by running:

```bash
aws configure
```
You will be asked to provide your AWS Access Key ID, Secret Access Key, Default region name, and Default output format. You can find this information in your AWS Management Console. If you don’t have access to this information, you need to contact your AWS administrator.

```bash
AWS Access Key ID [None]: Your-Access-Key
AWS Secret Access Key [None]: Your-Secret-Access-Key
Default region name [None]: us-west-2
Default output format [None]: json
```

And that's it! Your AWS CLI is now installed and configured.