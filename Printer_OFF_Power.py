import requests

url = "http://192.168.1.32/cm?cmnd=POWER1%20OFF"
response = requests.get(url)
response_json = response.json()
print(response_json)
