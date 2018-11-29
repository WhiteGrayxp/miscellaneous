import cv2
import numpy as np
import datetime

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
            (x, y, w, h) = cv2.boundingRect(c)
            cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)

 
        cv2.imshow("Security Feed", frame)
        firstFrame = gray.copy()

        if cv2.waitKey(1)&0xff == ord('q'):
            break

    camera.release()
    cv2.destroyAllWindows()

def stop():
    camera.release()
    cv2.destroyAllWindows()


if __name__ == "__main__":
    takePicture()
    detect()