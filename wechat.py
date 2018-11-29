import itchat
import requests
import threading
import cv2
import time
import numpy as np
import datetime
import GetNotification

key = '8edce3ce905a4c1dbb965e6b35c3834d'
api_url = 'http://www.tuling123.com/openapi/api'
flag = False

camera = cv2.VideoCapture(0)
if(camera.isOpened()==False):
    print("摄像头打开失败~")
width = int(camera.get(3))
height = int(camera.get(4))

def takePicture():
    name = datetime.datetime.now().strftime('%F')
    path = 'G:\Python\Project\\'+name+'.jpg'
    firstTime = True
    while(1):
        (ret,frame) = camera.read()
        cv2.waitKey(1)
        if not ret:
            print("拍照失败~")
            break
        if firstTime:
            cv2.imwrite(path,frame)
            firstTime = False
        cv2.imshow('test',frame)
        cv2.waitKey(1)
        if not firstTime:
            break
    cv2.destroyAllWindows()
    return path
 
def detect():
    global flag
    firstFrame = None
    print("按Q键退出~")
    while True:
        (grabbed, frame) = camera.read()
        if not grabbed:
            print('失败！')
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        gray = cv2.GaussianBlur(gray, (21, 21), 0)
 
        if firstFrame is None:
            firstFrame = gray
            continue
        #前后景作差
        frameDelta = cv2.absdiff(firstFrame, gray)
        #过滤掉部分细节
        thresh = cv2.threshold(frameDelta, 25, 255, cv2.THRESH_BINARY)[1]
        #膨胀
        thresh = cv2.dilate(thresh, None, iterations=2)
        #寻找较大的轮廓
        (_, cnts, _) = cv2.findContours(thresh.copy(), cv2.RETR_CCOMP, cv2.CHAIN_APPROX_SIMPLE)
        for c in cnts:
            # 出现一个大于8000的轮廓即表示检测到移动物体
            if cv2.contourArea(c) < 8000:
                continue
            flag = True
            (x, y, w, h) = cv2.boundingRect(c)
            cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)

        if flag:
            cv2.imwrite("G:\Python\Project\warning.jpg",frame)
            print('发现异常')
            itchat.send_msg('发现异常！',toUserName='white_grayxp')
            #itchat.send_image('G:\Python\Project\warning.jpg',toUserName='white_grayxp')

        cv2.imshow("运动检测", frame)
        firstFrame = gray.copy()

        if cv2.waitKey(1)&0xff == ord('q'):
            cv2.destroyAllWindows()
            break
    cv2.destroyAllWindows()

##微信机器人准备


def get_response(msg):
    data = {
        'key':key,
        'info':msg,
        'userid':'wechat_robot'
    }
    try:
        response = requests.post(api_url,data = data).json()
        return response.get('text')
    except:
        return 

@itchat.msg_register(itchat.content.TEXT)
def text_reply(msg):
    default_reply = 'I received :' + msg['Text']
    
    #获取院网通知
    if msg['Text'] == '院网通知':
        notice_reply = ''
        notice_list = GetNotification.get_notices()
        for i in range(10):
            notice_reply += notice_list[i] + "\n"
        return notice_reply
    elif msg['Text'] == '拍照':
        path = takePicture()
        itchat.send_image(path,msg.fromUserName)
        return "拍好啦"
    # elif msg['Text'] == '检测':
    #     print(threading.current_thread().name)
    #     t = threading.Thread(target = Detection.detect,name='detectThread')
    #     t.start()
    #     print(threading.current_thread().name)
    #     return "开始监控~,可以发送“停止监控”指令来暂停哦！"
    # elif msg['Text'] == '停止监控':
    #     Detection.stop()
    #     return "已经结束监控啦！"

    #正常情况下图灵机器人自动回复
    reply = get_response(msg['Text'])
    return reply or default_reply

if __name__ == '__main__':
    itchat.auto_login()
    # 微信机器人开始回复
    ## itchat.run()
    itchat.run(blockThread=False)
    # 开启监控线程，默认一直运行
    # print(threading.current_thread().name)
    # t = threading.Thread(target = detect,name='detectThread')
    # t.start()
    # print(threading.current_thread().name)
    detect()
        
    

    
