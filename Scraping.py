import requests
from bs4 import BeautifulSoup
import csv

# Khởi tạo danh sách để lưu trữ dữ liệu
data = []
fieldnames = ['Danh mục','Tên sản phẩm', 'Giá','Tên nhà thuốc']
mc = 'Nhà thuốc Minh Châu'
categories1 ={'hoa-my-pham-trang-','thuc-pham-cao-cap-trang-','thiet-bi-y-te-trang-','thuc-pham-chuc-nang-trang-','thuoc-bo-than-trang-','thuoc-giam-can-trang-','thuoc-khong-ke-don-trang-','thuoc-tan-duoc-trang-','thuoc-xuong-khop-trang-'}
#                 74                       17                          36                      135                        24                      8                        6                        190                         30
with open('data.csv', 'w', newline='', encoding='utf-8') as f:
    for category in categories1:
        page = 1
        print(category,'\n')
        # Lấy dữ liệu theo trang
        while True:
            print(f"Đang lấy dữ liệu trang {page}...")
            url = f'https://nhathuocminhchau.com/{category}{page}/'
            response = requests.get(url)
            soup = BeautifulSoup(response.content, 'html.parser')
            products = soup.find_all('div', class_='itemsanpham')
            
            #Tìm tổng số trang nếu đủ rồi thì thoát vòng lặp
            pagination_element = soup.find('ul', class_='pagination')
            if pagination_element:
                # Trích xuất tất cả các thẻ <li> trong phần tử pagination
                pages = pagination_element.find_all('li')        
                # Lấy trang cuối cùng bằng cách trích xuất nút "Last"
                last_page_element = pages[-1]
                last_page = last_page_element.text.strip()
                print(last_page)
                if last_page == '>':
                    #Bắt đầu lấy dữ liệu
                    for product in products:
                        title = soup.find('h1',class_='title').text.strip()
                        name = product.find('p', class_='tieude').text.strip()
                        price = product.find('div', class_='gia').text.strip()
                        data.append({'Danh mục':title,'Tên sản phẩm': name, 'Giá': price,'Tên nhà thuốc' : mc})
                else:
                    for product in products:
                        title = soup.find('h1',class_='title').text.strip()
                        name = product.find('p', class_='tieude').text.strip()
                        price = product.find('div', class_='gia').text.strip()
                        data.append({'Danh mục':title,'Tên sản phẩm': name, 'Giá': price,'Tên nhà thuốc' : mc})
                    break
                page+=1
        #Lưu dữ liệu vào file CSV
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(data)
    print('Hoàn thành!')