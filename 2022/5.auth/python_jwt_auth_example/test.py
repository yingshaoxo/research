from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def main():
    response = client.get("/")
    # print(response.text)
    # assert response.status_code == 200
    # assert response.json() == {"msg": "Hello World"}
    assert "Hello" in response.text


    # get jwt string
    response = client.post("/login/", json={
        "username": "joe",
        "password": "password"
    })
    response = response.json()
    # print(response)
    assert "result" in response and "token" in response.get("result")
    jwt_string = response.get("result").get("token")


    # get data
    response = client.post("/get_data/", json={
        "token": jwt_string,
        "data_type": 1,
    })
    response = response.json()
    # print(response)
    assert "error" in response and response.get("error") == None


    # get data with wrong jwt
    response = client.post("/get_data/", json={
        "token": "asldfahskgdhasghdlasgdkashgdjkasdhsa",
        "data_type": 1,
    })
    response = response.json()
    assert "error" in response and response.get("error") != None
