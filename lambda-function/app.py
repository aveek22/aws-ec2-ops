import boto3

# Define AWS Region and EC2 instance IDs
region = 'eu-west-1'
instances = ['i-007193c6f8f134307']

# Create the EC2 client
ec2 = boto3.client('ec2', region_name=region)

def main(event, context):
    
    # Get operation from event
    operation = event["operation"]

    if operation == "start":
        start_ec2()
    elif operation == "stop":
        stop_ec2()
    else:
        print("Invalid Operation.")
    
    
def stop_ec2():
    ec2.stop_instances(InstanceIds=instances)
    print('Stopping EC2: ' + str(instances))

def start_ec2():
    ec2.start_instances(InstanceIds=instances)
    print('Starting EC2: ' + str(instances))