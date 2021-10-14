import json

print("loading function")


def lambda_handler(event, context):

    transactionId = event['queryStringParameters']['transactionId']
    transactionType = event['queryStringParameters']['type']
    transactionAmount = event['queryStringParameters']['amount']

    print("transactionId= "+transactionId)
    print("transactionType= "+transactionType)
    print("transactionAmount= "+transactionAmount)

    transactionResponse = {}
    transactionResponse['transactioId'] = transactionId
    transactionResponse['type'] = transactionType
    transactionResponse['amount'] = transactionAmount
    transactionResponse['message'] = 'hello from my lambda'


    responseObject = {
    
    }

    responseObject['statusCode'] = 200
    responseObject['headers'] = {}
    responseObject['headers']['Content-type'] = 'application/json'
    responseObject['body'] = json.dumps(transactionResponse)

    return responseObject
