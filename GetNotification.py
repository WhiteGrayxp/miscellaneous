import urllib.request
import urllib.parse
from bs4 import BeautifulSoup


web_url = 'http://www.isee.zju.edu.cn/notice'
user_agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.63 Safari/537.36 Qiyu/2.1.1.1'
list = []

def get_notices():
    request = urllib.request.Request(web_url)
    request.add_header('User-Agent', user_agent)
    response = urllib.request.urlopen(request)
    html = response.read()

    print("开始解析网页~~~")
    soup = BeautifulSoup(html, 'html.parser')
    all_a = soup.find_all('div', 'content')
    for each in all_a[1].find_all('a'):
        title = each['title']
        url = each.get('href')
        if not 'http' in url:
            url = 'http://www.isee.zju.edu.cn' + url
        list.append(title + ":" + url)
    print("解析完成")
    return list

if __name__ == "__main__":
    notice_list = get_notices()
    notice_reply = ""
    for i in range(10):
        notice_reply += notice_list[i] + "\n"
    print(notice_reply)