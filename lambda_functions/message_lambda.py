
import json


def lambda_handler(event, context):
    
    message = json.loads(event['body'])
    
    #new_first_name = message["first_name"] + "_from_lambda"
    #new_last_name = message["last_name"] + "_from_lambda"
    #
    #message["first_name"] = new_first_name
    #message["last_name"] = new_last_name

    id = message['id'];
    userId = message['userId'];
    sessionId = message['sessionId'];
    isMe = message['isMe'];
    messageContent = message['messageContent'];
    createdAt = message['createdAt'];

    message['messageContent'] = messageContent + "_from_AWS_Lambda"
    
    responseObject = {}

    responseObject['statusCode'] = 200
    responseObject['headers'] = {}
    responseObject['headers']['Content-type'] = 'application/json'
    responseObject['body'] = json.dumps(message)

    return responseObject
     
