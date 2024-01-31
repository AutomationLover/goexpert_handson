# CI/CD Pipeline - Introduction 

## Level 1 (Intern)
Task: Clone a sample repository from GitHub. Learn to create a new branch and push changes.
Objective: Basic hands-on with Git and GitHub.

Steps:

```markdown
1. Open your terminal or command prompt.
2. Navigate to the directory where you want to clone the repository.
3. Run the following command: `git clone https://github.com/username/repository.git` (replace the URL with the GitHub repository URL you want to clone).
4. To create a new branch, use the command: `git checkout -b branch-name` (replace `branch-name` with the name you want to give to your new branch).
5. Make your changes in the files.
6. Stage your changes by using: `git add .`
7. Commit your changes by using: `git commit -m "commit message"` (replace `commit message` with a brief description of your changes).
8. Push your changes to the remote repository by using: `git push origin branch-name`.
```
---

## Level 2 (Junior)
Task: Set up a basic CI pipeline to validate the code and commit the changes. Objective: Implement CI basics for the frontend or the backend.


Steps:

```markdown
1. Navigate to your GitHub repository.
2. Click on the 'Actions' tab at the top of your repository.
3. Click on 'set up a workflow yourself'.
4. Add the following steps to your workflow file:

```
```yaml
# This is a basic workflow to help you get started with Actions

name: CI

# Controls when the action will run. 
on:
  # Triggers the workflow on push or pull request events but only for the master branch
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]

  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:

# A workflow run is made up of one or more jobs that can run sequentially or in parallel
jobs:
  # This workflow contains a single job called "build"
  build:
    # The type of runner that the job will run on
    runs-on: ubuntu-latest

    # Steps represent a sequence of tasks that will be executed as part of the job
    steps:
    # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it
    - uses: actions/checkout@v2```
```markdown
5. After editing the workflow, click on 'Start commit' at the top right corner.
6. Enter your commit message and select whether to commit directly to the master branch or create a new branch and start a pull request. Click on 'Commit new file' to finalize your setup.
```
---

## Level 3 (Mid-level)
Task: Set up a Jenkins server on a cloud and a DNS.
Objective: Prepare for advanced CI/CD configurations.

Steps:

```markdown
1. Create an account on a cloud service provider (like AWS, Google Cloud, etc).
2. Create a new instance (VM) on your cloud provider.
3. Install Jenkins on your instance. You can do this by SSH into your instance and run the command `sudo apt install jenkins`.
4. Open the Jenkins UI by entering your instance's IP address followed by :8080 in your browser (e.g., 192.168.1.2:8080).
5. Complete the Jenkins installation by following the prompts.
6. To set up a DNS, go to your DNS provider (like GoDaddy, Namecheap, etc) and create a new A Record with your instance's public IP address.
```
Please note: The detail of each step may vary based on the cloud service provider and DNS provider you choose. Always refer to the official documentation of your chosen providers for specific instructions.