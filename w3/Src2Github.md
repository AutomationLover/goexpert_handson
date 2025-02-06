Steps to connect to github

1. In AWS CodePipeline, create a new pipeline or edit an existing one.
2. When configuring the source stage, select "GitHub (Version 2)" as the source provider.
3. Click on "Connect to GitHub" to create a new connection.
4. In the AWS Developer Tools window, provide a unique name for your connection.
5. Click "Install a new app" to open the AWS Connector for GitHub window.
6. Select the appropriate GitHub account or organization where your repository is located.
7. Choose your repository access settings. You can grant access to all repositories or select specific ones.
8. Click "Save" to complete the GitHub app installation.
9. Back in the AWS Developer Tools window, you'll see a unique App ID assigned by AWS. Click "Connect" to finalize the connection.
10. In the CodePipeline setup, select your repository and branch from the dropdown menus.
11. Complete the rest of the pipeline configuration and save your changes.

Ref: https://plainenglish.io/blog/how-to-set-up-simple-ci-cd-using-aws-codepipeline-with-github-8dc265470184
