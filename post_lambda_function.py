import json
def lambda_handler(event, context):
    #message = 'Hello {} {}!'.format(event['first_name'], event['last_name'])  
    
    #message = event['body']
    
    message = json.loads(event['body'])
    
    new_first_name = message["first_name"] + "_from_lambda"
    new_last_name = message["last_name"] + "_from_lambda"
    
    message["first_name"] = new_first_name
    message["last_name"] = new_last_name
    
    responseObject = {}

    responseObject['statusCode'] = 200
    responseObject['headers'] = {}
    responseObject['headers']['Content-type'] = 'application/json'
    responseObject['body'] = json.dumps(message)

    return responseObject


#Following is the sample POST body
# {
#     "first_name": "John",
#     "last_name": "Smith"
# }

#Following is the POST response body
# {
#     "first_name": "John_from_lambda",
#     "last_name": "Smith_from_lambda"
# }

