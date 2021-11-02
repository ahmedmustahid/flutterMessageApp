import os
import boto3
import copy
import json
import pprint
import datetime
from chatbot import Chatbot
from boto3.dynamodb.conditions import Key


def _localtime_str(time_zone=9): 
    date = datetime.datetime.now(datetime.timezone.utc)+datetime.timedelta(hours=int(time_zone))
    date_str = date.strftime("%Y-%m-%dT%H:%M:%S.%f")
    return date_str
 
def _save_jsonfile_into_s3(message, FILEPATH, BUCKET_NAME):
    s3 = boto3.resource('s3')
    obj = s3.Object(BUCKET_NAME, FILEPATH)
    body_contents = json.dumps(message, indent=4, sort_keys=True, ensure_ascii=False)
    obj.put(Body=body_contents)
    
def lambda_handler(event, context):
    
    
    
    
    with open("Chatbot_src.json", "r") as fp: # Q_NAIZAI, Q_GAIZAI などを Q_dic, Flow_dic へ格納済み
        Chatbot_src = json.load(fp)
        
    TARGET = "車"
    who_list = copy.deepcopy(Chatbot_src["who_list"])
    when_list = copy.deepcopy(Chatbot_src["when_list"])
    where_list = copy.deepcopy(Chatbot_src["where_list"])
    
    Q_dic = copy.deepcopy(Chatbot_src["Q_dic"])
    Flow_dic = copy.deepcopy(Chatbot_src["Flow_dic"])
    
    intro = Chatbot_src["intro"]
    filer = Chatbot_src["filer"]
    add = Chatbot_src["add"]
    conclusion = Chatbot_src["conclusion"]

    print(event)
    message = json.loads(event['body'])
    
    dynamoDb = boto3.resource('dynamodb')
    tableName='zaichatbotDb2'
    dynamoTable = dynamoDb.Table(tableName)
    dynamoTable.put_item(Item=message)
    
    
    chat_id = message["id"]

    # ユーザーのメッセージをバケットへ保存
    save_filepath = os.path.join("user", chat_id+"_user.json")
    _save_jsonfile_into_s3(message, FILEPATH=save_filepath, BUCKET_NAME="zaichatbotjsonstorage")

    uid = message["userId"]
    try:
        session_num = int(message["sessionId"])
    except:
        session_num = -1
    #if event["sessionId"]=="":
    #    session_num = -1
    #else:
    #    session_num = int(event["sessionId"])
    if message["flowId"]=="":
        flow_key = "START"
    else:  
        flow_key = message["flowId"]
    utext = message["messageContent"] # .encode().decode('unicode-escape') # unicode文字列になっているためエンコーディング
    timestamp = message["createdAt"] # 使わない
    
    chat_model = Chatbot(TARGET, who_list, when_list, where_list, Q_dic, Flow_dic, intro, filer, add, conclusion)
    
    res = chat_model.say_next(chat_id=chat_id, uid=uid, utext=utext, flow_key=flow_key, session_num=session_num)
    filer, ctext, next_key, session_num = res[0], res[1], res[2], res[3]
    
    #print(filer)
    #print(ctext)
    if type(ctext)==str: # intro や colusion など
        ctext = [ctext] # list型へ変換
    if filer!="":
        filer = [filer]
        ctext = filer+ctext # [filer, ctext[0], ctext[1], ...] とする.

    response = {}
    response["id"] = chat_id
    response["userId"] = uid
    response["flowId"] = next_key
    response["sessionId"] = str(session_num)
    response["messageContent"] = "\n".join(ctext)
    response["isMe"] = False
    response["createdAt"] = _localtime_str()
    print(response)
    dynamoTable.put_item(Item=response)
    
    
    # チャットボットのメッセージをバケットへ保存
    save_filepath = os.path.join("user", chat_id+"_chatbot.json")
    _save_jsonfile_into_s3(response, FILEPATH=save_filepath, BUCKET_NAME="zaichatbotjsonstorage")
    
    
    
    
    
    
    responseObject = {}
    responseObject['statusCode'] = 200
    responseObject['headers'] = {}
    responseObject['headers']['Content-type'] = 'application/json'
    #responseObject['insideDynamo']= False
    
    print("flowId ",message['flowId'])
    print("flowId ",message['sessionId'])
    if message["flowId"]=="START" and message["sessionId"]=="-1":
        queryResultFromDynamo = dynamoTable.query(
            KeyConditionExpression=Key('userId').eq(uid) ,
            FilterExpression= 'sessionId <> :sessionIdValue',
            ExpressionAttributeValues= {":sessionIdValue": "-1"}
        )
        
        responseObject['body'] = json.dumps(queryResultFromDynamo['Items'])
    else:
        responseObject['body'] = json.dumps(response)
    
    
    
    print("responseObject body")
    print(responseObject['body'])
    # return 参考 : https://qiita.com/baikichiz/items/2de7c4c0dcf9b051037a
    return responseObject
