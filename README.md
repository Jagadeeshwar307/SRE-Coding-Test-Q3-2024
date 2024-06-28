# SRE-Coding-Test-Q3-2024
Alert Setup
An alert is configured to trigger if more than 5 such entries are detected within a 10-minute window.

Steps
Log into your Sumo Logic account.
Navigate to the Search tab.
Enter the query mentioned above.
Set up an alert for the query:
Click on Alerts in the search results page.
Configure the alert to trigger if the count exceeds 5 within a 10-minute window.
Part 2: AWS Lambda Function
Lambda Function Implementation
A Python AWS Lambda function is created to:

Restart a specified EC2 instance.
Log the action.
Send a notification to an SNS topic.
Lambda Function Code
The code for the Lambda function is located in lambda_function.py.

Deployment and Testing
Deploy the Lambda function using the AWS Management Console or CLI.
Test the Lambda function to ensure it restarts the EC2 instance and sends the notification.
Part 3: IaC Setup
Terraform Configuration
A Terraform script is written to deploy the EC2 instance, Lambda function, and SNS topic.

Terraform Script
The Terraform configuration files are located in the terraform/ directory.

Deployment and Verification
Ensure Terraform is installed on your machine.
Navigate to the terraform/ directory.
Run terraform init to initialize the working directory.
Run terraform apply to deploy the infrastructure.
Verify that the resources are correctly created and the Lambda function works as expected.
Usage
Prerequisites
Sumo Logic account
AWS account with appropriate permissions
Terraform installed
Steps to Run
Follow the instructions in each part to set up the Sumo Logic query and alert, deploy and test the Lambda function, and deploy the infrastructure using Terraform.
Recording
Screen and audio recordings for each part of the project are available for review. These recordings demonstrate the implementation, deployment, and testing processes.
