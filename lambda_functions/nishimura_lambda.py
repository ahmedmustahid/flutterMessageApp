import copy
import json
import pprint
from chatbot import Chatbot

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


    if "queryStringParameters" in event.keys(): # テスト用
        event = event["queryStringParameters"]
    uid = event["uid"]
    session_num = int(event["session_num"])
    flow_key = event["flow_key"]
    utext = event["utext"] # .encode().decode('unicode-escape') # unicode文字列になっているためエンコーディング
    response_time = int(event["response_time"])
    
    chat_model = Chatbot(TARGET, who_list, when_list, where_list, Q_dic, Flow_dic, intro, filer, add, conclusion)
    
    if utext == "本日はこれで終了です" or utext == "本日はこれで終了です。": # 強制的に END へ遷移
        flow_key = "END"
    res = chat_model.say_next(uid=uid, utext=utext, flow_key=flow_key, session_num=session_num, response_time=response_time)
    filer, ctext, next_key, session_num = res[0], res[1], res[2], res[3]
    
    #print("Check")
    #print(filer)
    #print(ctext)
    if type(ctext)==str: # intro や colusion など
        ctext = [ctext] # list型へ変換
    if filer!="":
        filer = [filer]
        ctext = filer+ctext # [filer, ctext[0], ctext[1], ...] とする.

    response = {}
    response["ctext"] = ctext
    response["next_key"] = next_key
    response["session_num"] = session_num
    
    # return 参考 : https://qiita.com/baikichiz/items/2de7c4c0dcf9b051037a
    return {
        'isBase64Encoded': False,
        'statusCode': 200,
        'headers': {},
        'body': json.dumps(response)
    }

