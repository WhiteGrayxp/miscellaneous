import itchat
import requests

KEY = '1107d5601866433dba9599fac1bc0083'

def get_responce(msg):
    apiUrl = 'http://www.tuling123.com/openapi/api'
    data = {
        'key'   : KEY,
        'info'  : msg,
        'userid': 'wechat-robot'
    }
    try:
        r = requests.post(apiUrl,data=data).json()
        return r.get('text')
    except:
        return

@itchat.msg_register(itchat.content.TEXT)
def tuling_reply(msg):
    default_reply = 'I received ' + msg['Text']
    reply = get_responce(msg['Text'])
    return reply or default_reply

itchat.auto_login()
#itchat.run()
while 1:
    str = input("输入你想说的话：")
    default_reply = 'I received ' + str
    reply = get_responce(str)
    if not reply:
        reply = default_reply
    #itchat.send(reply, toUserName='filehelper')
    print("Reply: " + reply)
