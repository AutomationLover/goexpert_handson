# Week 2: Manual Deploy Frontend - CDN + Route 53 + ACM

## Level 1 (Intern)
**Task**: Set up a GitHub account and understand basic git commands. Create SSH keys and link them to GitHub.

**Objective**: Gain a foundational understanding of Git and SSH.

### Step by Step Guide:

1. **Set up a GitHub account**
    - Go to [GitHub](https://github.com/)
    - Click on `Sign up`
    - Fill out the form and click `Create an account`

2. **Understand basic git commands**
    - `git init`: Initializes a new Git repository
    - `git clone [url]`: Clones a repository into a new directory
    - `git add [file]`: Adds a file to the staging area
    - `git commit -m "[message]"`: Commits your files, adding the message "[message]"
    - `git push [alias] [branch]`: Pushes your changes to a remote repository
    - `git pull`: Updates your local repo with the remote repo

3. **Create SSH Keys and link them to GitHub**
    - Open your terminal and enter `ssh-keygen -t rsa -b 4096 -C " "your_email@example.com"`
    - This will start the process of generating the SSH keys. When asked to enter a file to save the key, press Enter to use the default location.
    - Next, you'll be asked to enter a passphrase. Enter a secure one and remember it.
    - Go to your GitHub account, click on your profile picture and go to `Settings`.
    - Click on `SSH and GPG keys` and then `New SSH key`.
    - Copy the SSH key you generated. You can do this by running `cat ~/.ssh/id_rsa.pub` in your terminal.
    - Paste the copied key into the `Key` field on GitHub and click `Add SSH key`.

4. **Use the SSH key from CLI**
    - To confirm that your SSH key is working correctly, try to SSH to GitHub by running `ssh -T git@github.com` in your terminal.
    - If you see a message like "Hi [your_username]! You've successfully authenticated...", then your SSH key is working correctly.

## Level 2 (Junior)
**Task**: Manually connect an S3-hosted website to a CDN.

**Objective**: Understand CDN integrations.

### Step by Step Guide:

1. **Host your website on S3**
   - Navigate to the AWS S3 console and create a new bucket with the name of your website, for example, "www.mywebsite.com".
   - Upload your website files to this bucket and make them public.
   - Enable static website hosting for your bucket. In the bucket properties, click on `Static website hosting`, select `Use this bucket to host a website` and specify your `index.html` as the Index document.
   
2. **Create a CloudFront distribution**
   - Go to the CloudFront console and click on `Create Distribution`. 
   - In the Origin Settings, select your S3 bucket as the `Origin Domain Name`.
   - In Default Cache Behavior Settings, select `Redirect HTTP to HTTPS` for Viewer Protocol Policy.
   - In the Distribution Settings, select `Price Class` based on your needs.
   - Set the `Alternate Domain Names (CNAMEs)` to your website domain (for example, "www.mywebsite.com").
   - Click on `Create Distribution`.

3. **Test from EC2s from different regions**
   - Create EC2 instances in different regions and try to access your website via the CloudFront distribution domain name. If the website loads correctly, your CDN setup is successful.

## Level 3 (Mid-level)
**Task**: Add a custom domain with Route 53 and HTTPS via ACM.

**Objective**: Complete a real-world static site setup.

### Step by Step Guide:

1. **Register a domain in Route 53**
   - Go to the Route 53 console and click on `Domain Registration`.
   - Click on `Register Domain`.
   - Follow the steps to register your domain.

2. **Create a hosted zone**
   - In the Route 53 console, go to `Hosted zones` and click on `Create Hosted Zone`.
   - Enter your domain name and click on `Create`.

3. **Create record sets**
   - In the `Hosted zones` details page, click on `Create Record Set`.
   - Leave the name blank and select `Type` as `A - IPv4 address`.
   - For `Alias`, choose `Yes` and in `Alias Target`, select the CloudFront distribution that you created earlier.
   - Click `Create`.

4. **Request a certificate in ACM**
   - Go to the Amazon Certificate Manager console and click on `Request a certificate`.
   - Enter your domain name and click `Review and request`.
   - Follow the steps to validate your domain.
   - Once your domain is validated, the status of your certificate will change to `Issued`.

5. **Add HTTPS to the CloudFront distribution**
   - Go back to your CloudFront distribution settings.
   - Click on `Edit`.
   - In `SSL Certificate`, select `Custom SSL Certificate` and choose the certificate you created in ACM.
   - Click on `Yes, Edit`.

Now you have a static website hosted on S3, served via a CloudFront distribution, with a custom domain from Route 53 and HTTPS via ACM. You can access your website using your custom domain.