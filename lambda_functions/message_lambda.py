
import json
import random
import datetime

def lambda_handler(event, context):
    
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

    return responseObject
     

