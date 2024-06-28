import boto3
import logging
 
# Initialize logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)
 
# Initialize boto3 clients
ec2 = boto3.client('ec2')
sns = boto3.client('sns')
 
# Constants
INSTANCE_ID = 'i-02cb8e11b5c3b816f'
SNS_TOPIC_ARN = 'arn:aws:sns:us-east-2:590183853068:SumoQuery1'
 
# Lambda function handler
def Sumo_Logic(event, context):
    try:
        # Restart the EC2 instance
        ec2.reboot_instances(InstanceIds=[INSTANCE_ID])
        logger.info(f'Restarted EC2 instance: {INSTANCE_ID}')
        # Publish a notification to SNS
        response = sns.publish(
            TopicArn=SNS_TOPIC_ARN,
            Message=f'EC2 instance {INSTANCE_ID} has been restarted.',
            Subject='EC2 Instance Restarted'
        )
        logger.info(f'SNS publish response: {response}')
    except Exception as e:
        logger.error(f'Error: {str(e)}')
        raise e
