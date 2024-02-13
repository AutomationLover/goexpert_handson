# Week 3: Deploy Statistic webpage with CICD

## Level 1 (Intern)
**Task**: Create CodeCommit repository

**Objective**: Understand how to set up a CodeCommit repository

### Step by Step Guide:

1. **Create a CodeCommit repository**
    - Go to the AWS Management Console and open the CodeCommit console at https://console.aws.amazon.com/codecommit/.
    - Choose `Create repository`.
    - In `Repository name`, enter a name for your repository.
    - (Optional) In `Description`, enter a description for your repository.
    - Choose `Create`.
2. **Create Git Crednetial**
    - Service `User` -> your admin account -> Security credentials -> HTTPS Git credentials for AWS CodeCommit 
3. **Clone the repository**
    - On the `Repositories` page, choose the name of the repository you want to clone.
    - Choose `Clone URL`, and then choose `Clone HTTPS`.
    - Open a terminal and navigate to the local directory where you want to clone the repository.
    - Run the `git clone` command followed by the HTTPS URL you copied. For example, `git clone https://git-codecommit.us-east-2.amazonaws.com/v1/repos/MyDemoRepo` and input the username and password created in previous step.

## Level 2 (Junior)
**Task**: Build pipeline to push updated index.html file to bucket www.yourdomain.click via git push

**Objective**: Understand how to use CodePipeline to automate the deployment process.

### Step by Step Guide:

1. **Create a CodePipeline**
    - Go to the AWS Management Console and open the CodePipeline console at https://console.aws.amazon.com/codepipeline/.
    - Choose `Create pipeline`.
    - In `Pipeline name`, enter a name for your pipeline.
    - Choose `Next`.

2. **Configure the source stage**
    - In `Source provider`, choose `AWS CodeCommit`.
    - In `Repository name`, choose the name of your CodeCommit repository.
    - In `Branch name`, choose the name of the branch `main` that you want the pipeline to use.
    - Choose `Next`.

3. **Skip the build stage**
    - Choose `Skip build stage`.
    - In the warning message that's displayed, choose `Skip`.

4. **Configure the deploy stage**
    - In `Deploy provider`, choose `Amazon S3`.
    - In `Bucket`, choose the name of the S3 bucket where your index.html file is stored.
    - Choose `Next`.

5. **Review the pipeline**
    - Review the details of your pipeline.
    - Choose `Create pipeline`.

6. **Push changes to the CodeCommit repository**
    - Navigate to your local project directory.
    - Make some changes to your index.html file.
    - Use `git add` to stage the changes, `git commit -m "Your message"` to commit the changes, and `git push` to push the changes to your CodeCommit repository.
    - Once the changes are pushed, your pipeline will automatically start and deploy the updated index.html file to your S3 bucket.

## Level 3 (Mid-level)
**Task**: Add a testing phase in your pipeline to validate your changes before the deployment.

**Objective**: Understand how to add a testing phase in the CodePipeline.

### Step by Step Guide:

1. **Create a CodeBuild project**
    - Go to the AWS Management Console and open the CodeBuild console at https://console.aws.amazon.com/codebuild/.
    - Choose `Create project`.
    - In `Project name`, enter a name for your project.
    - In `Source`, select `AWS CodeCommit` and choose your repository.
    - In `Environment`, choose a managed image and select the `Ubuntu` operating system, `Standard` runtime, and `aws/codebuild/standard:4.0` image.
    - In `Buildspec`, choose 'Use a buildspec file', and in your repository, include a buildspec file that contains commands to validate your index.html file.
    - Choose `Create build project`.

2. **Add the build stage to your pipeline**
    - Go to the CodePipeline console at https://console.aws.amazon.com/codepipeline/.
    - Choose the name of your pipeline.
    - Choose `Edit`.
    - In the pipeline structure area, choose `+ Add stage`, and then enter a name for the stage.
    - In the new stage, choose `+ Add action group`.
    - In the `Add action` dialog box, in `Action name`, enter a name.
    - In `Action provider`, choose `AWS CodeBuild`.
    - In `Input artifacts`, choose `SourceArtifact`.
    - In `Project name`, choose the name of your CodeBuild project.
    - Choose `Done`.

3. **Update the deploy stage**
    - In the deploy stage of your pipeline, for `Input artifacts`, choose `BuildArtifact`.

4. **Save your pipeline**
    - Choose `Done`, and then choose `Save`.

Now, whenever you push changes to your CodeCommit repository, your pipeline starts automatically. The pipeline fetches the latest version of your index.html file, validates it using the commands in your buildspec file, and if the validation is successful, it deploys the index.html file to your S3 bucket.