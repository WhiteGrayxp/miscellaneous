import itchat


@itchat.msg_register(itchat.content.TEXT)
def text_reply(msg):
    print(msg.fromUserName)
    return msg['Text']


itchat.auto_login()
owner = itchat.search_friends(name='向平')[0]
itchat.send_image(r'D:\code\Python\2018-11-29.jpg', owner['UserName'])
itchat.run(blockThread=True)

