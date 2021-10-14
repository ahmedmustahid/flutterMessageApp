import json

def lambda_handler(event, context):
    time =  event["time"]
    name = event["queryStringParameters"]["name"]
    city = event["queryStringParameters"]["city"] 
    day = event["headers"]["day"]
    
    myString = "Good " +  time + " " + name  +" of " + city  + ". Happy " + day + " day"
    
    responseBody = {
        'message': myString,
        'input': event
    }

    responseCode = 200
    
    # The output from a Lambda proxy integration must be 
    # in the following JSON object. The 'headers' property 
    # is for custom response headers in addition to standard 
    # ones. The 'body' property  must be a JSON string. For 
    # base64-encoded payload, you must also set the 'isBase64Encoded'
    # property to 'true'.

    response = {
        "statusCode": responseCode,
        "headers": {
            "x-custom-header" : "my custom header value"
        },
        "body": json.dumps(responseBody)
    }

    print("response: " + json.dumps(responseBody))
    return response
    
    # TODO implement
    #return {
    #    'statusCode': 200,
    #    'body': json.dumps('Hello from Lambda!')
    #}
