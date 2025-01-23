To manage multiple AWS accounts on macOS using AWS CLI and switch between them:

Set up named profiles for each account:

```
aws configure --profile personal
aws configure --profile work
```

Enter the respective access key, secret key, region, and output format for each profile.


Verify profile configuration in ~/.aws/credentials and ~/.aws/config files.


Switch between accounts using one of these methods:

a. Use the --profile option with each command:

```
aws s3 ls --profile personal
aws ec2 describe-instances --profile work
```

b. Set the AWS_PROFILE environment variable:

```
export AWS_PROFILE=personal
```

To switch, update the variable:

```
export AWS_PROFILE=work
```

Verify the active profile:

```
aws sts get-caller-identity
```
This approach allows easy management and switching between multiple AWS accounts using the AWS CLI on macOS
