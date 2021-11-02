
import json
import random
import datetime
import boto3



def lambda_handler(event, context):
    
    # string = "dfghj"
    # encoded_string = string.encode("utf-8")

   
    
    message = json.loads(event['body'])
    


    id = message['id']
    userId = message['userId']
    sessionId = message['sessionId']
    isMe = message['isMe']
    messageContent = message['messageContent']
    createdAt = message['createdAt']
    
    
    
    message['messageContent'] = messageContent + "_from_AWS_Lambda"
    message['isMe'] = False
    message['flowId']="my_flow_id"+str(random.randint(1,10000))
    message["sessionId"]="my_session_id"+str(random.randint(100000,10000000))
    message['createdAt'] = datetime.datetime.now().isoformat()
    
    responseObject = {}

    responseObject['statusCode'] = 200
    responseObject['headers'] = {}
    responseObject['headers']['Content-type'] = 'application/json'
    responseObject['body'] = json.dumps(message)
    
    
    bucket_name = "zaichatbotjsonstorage"
    file_name = "hello.json"
    s3_path = "100001/20211019/" + file_name

    s3 = boto3.resource("s3")
    s3.Bucket(bucket_name).put_object(Key=s3_path, Body=json.dumps(message))
    

    return responseObject
     

