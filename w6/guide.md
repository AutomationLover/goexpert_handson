## Week 6: Serverless

## Level 1 (Intern)
**Task**: Create HelloWorld website with Lambda, and API Gateway
**Objective**: Understand how to set up a Lambda and API Gateway

### Step by Step Guide:

1. **Log into the AWS Management Console**
    - Go to aws.amazon.com and then click on 'Sign In to the Console'. Select region `us-west-2`.

2. **Navigate to AWS Lambda**
    - In the AWS Management Console, go to Services and then select Lambda under Compute.

3. **Create a New Lambda Function**
    - Click on 'Create Function'. Choose 'Author from scratch'. Name your function (e.g HelloWorld) and choose Author from scratch, Python 3.12 for the runtime, Architecture x86_64.

4. **Write your Lambda Function**
    - In the Function code section, delete the existing code and replace it with a simple HelloWorld application. For example:

        ```python
        def lambda_handler(event, context):
            return {
                'statusCode': 200,
                'body': 'Hello, World!'
            }
        ```

5. **Save Your Lambda Function**
    - Wait till you see 'was successfully saved.' in the top of the console.


6. **Test Your Lambda Function**
    - Click on 'Test' in the top right corner of the console. Use default settings.
  
7. **Configure the API Gateway**
    - Click `Create API`. Select 'REST API' and then click 'Build'. Fill in the details for the new API, choose the 'New API' option, give it a name (e.g HelloWorldAPI), endpoint type: regional and then click 'Create API'.

8. **Create a new GET method**
    - In the Resources panel, select the root resource ('/'),  click button 'Create Method'. In the dropdown that appears under the resource, select 'GET'; for Lambda function select us-west-2 and HelloWorld lambda, which created in previous step; and then click `Create method` buttom.


9. **Deploy the API**
    - In the Actions dropdown, select 'Deploy API'. For 'Deployment stage', select '[New Stage]' and give it a name (e.g test). Click 'Deploy'.

10. **Test Your API**
    - After deployment, the 'Invoke URL' will be displayed at the top. Click on the URL to open it in a new browser tab. You should see 'Hello, World!' displayed in the browser, showing that your Lambda function is working correctly through the API Gateway.

## Level 2 (Junior)
**Task**: add feature of response the website visit count in /visit with DDB
**Objective**: Understand how Lambda connecting with DDB.

### Step by Step Guide:

1. **Create a DynamoDB Table**
    - Go to Services and select DynamoDB under Databases. Click on 'Create table'. Name your table (e.g. VisitCount), define a primary key (e.g. id), and leave the rest as default. Click on 'Create'.

2. **Modify your Lambda Function**
    - Go back to your HelloWorld lambda function. In the Function code section, add the following code:

        ```python
        import boto3
        import json

        def lambda_handler(event, context):
            dynamodb = boto3.resource('dynamodb')
            table = dynamodb.Table('VisitCount')
            response = table.update_item(
                Key={'id': 'website'},
                UpdateExpression='ADD visits :inc',
                ExpressionAttributeValues={':inc': 1},
                ReturnValues="UPDATED_NEW"
            )
            return {
                'statusCode': 200,
                'body': json.dumps('Hello, World! You are visitor number : ' + str(response['Attributes']['visits']))
            }
        ```
    - Click on 'Save'.

3. **Assign IAM Role To Lambda Function**
    - Go to the `Configuration`->`Permissions` tab of your lambda function and click `Edit` on the right of `Execution role`. Under `Existing role` click `view the HelloWorld-role-xxxx role`. This will take you to the IAM Management Console. You will see a `IAM` -> `roles` page. 
    Click `Add permissions` -> `Attach policy`.
    . choose `AmazonDynamoDBFullAccess` policy and click `Add permission`.

4. **Deploy Your Lambda update**
    - Click `Deploy`.

5. **Test Your Lambda**
    - Click `Test`.

4. **Test Your API**
    - Go back to your API Gateway and click on the 'Invoke URL' again. Now, each time you refresh the page, the count will increase, showing that your Lambda function is connecting correctly with DynamoDB.

## Level 3 (Mid-level)
**Task**: Setup Codecommit and pipeline.
**Objective**: Understand how to set it up in the CodePipeline.

### Step by Step Guide:

Read and try to follow steps in https://aws.amazon.com/blogs/devops/using-aws-codepipeline-for-deploying-container-images-to-aws-lambda-functions/