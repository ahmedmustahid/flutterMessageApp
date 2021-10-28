import json
import random
import datetime
import boto3

def returnResponseIterator():
    client = boto3.client("s3")
    bucket_name = "zaichatbotjsonstorage"
    paginator = client.get_paginator('list_objects_v2')
    response_iterator = paginator.paginate(Bucket=bucket_name)
    
    for page in response_iterator:
        if page['KeyCount'] > 0:
            for item in page['Contents']:
                yield item




def lambda_handler(event, context):
    
    
    message = json.loads(event['body'])
    userId = message['userId']
    bucket_name = "zaichatbotjsonstorage"
    
    s3 = boto3.resource('s3')
    
    
    items = []
    for item in returnResponseIterator():
        #print(item)
        pathHead = item['Key'].split('/')[0]
        
        
        if pathHead=="chatbot" or pathHead=="user": 
            content_object = s3.Object(bucket_name, item['Key'])
            file_content = content_object.get()['Body'].read().decode('utf-8')
            itemDict = json.loads(file_content)
        
        
            if itemDict['userId'] == userId:
                items.append(item)

    #id = message['id']
    
    #sessionId = message['sessionId']
    isMe = message['isMe']
    messageContent = message['messageContent']
    #createdAt = message['createdAt']
    
    if (isMe == True):
        s3_path = "user"
    else:
        s3_path = "chatbot"
        
 
    #message = item 
    message['messageContent'] = messageContent + "_from_AWS_Lambda"
    #message['isMe'] = False
    #message['flowId']="my_flow_id"+str(random.randint(1,10000))
    #message["sessionId"]="my_session_id"+str(random.randint(100000,10000000))
    #message['createdAt'] = datetime.datetime.now().isoformat()
    
    message['items'] = items 
    
    
    responseObject = {}

    responseObject['statusCode'] = 200
    responseObject['headers'] = {}
    responseObject['headers']['Content-type'] = 'application/json'
    responseObject['body'] = json.dumps(message, indent=4, sort_keys=True, default=str)
    
    
    
    file_name = "hello.json"
    #s3_path = "100001/20211019/" + file_name

    #s3 = boto3.resource("s3")
    #s3.Bucket(bucket_name).put_object(Key=s3_path, Body=json.dumps(message))
    

    return responseObject
     