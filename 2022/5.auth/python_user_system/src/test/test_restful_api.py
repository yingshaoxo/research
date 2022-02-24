import src.models as models
from datetime import datetime
import src.database.sqlite as sqlite
import src.auth as auth

from fastapi.testclient import TestClient

async def run(myDatabase: sqlite.MyDatabase, client: TestClient):
    response = client.get("/")
    assert response.status_code == 200
    # assert response.json() == {"msg": "Hello World"}
    assert "Hello" in response.text

    # test delete all users
    await myDatabase.deleteAllUsers()

    # consts
    email = "yingshaoxo@gmail.com"
    username = "yingshaoxo"
    password = "password"

    # test user register
    response = client.post("/register/", json={
        "email": email,
        "username": username,
        "password": password
    })
    response = response.json()
    # print(response)
    assert "user_id" in response
    user_id = response.get("user_id")

    # test user login
    response = client.post("/login/", json={
        "email": email,
        "password": password
    })
    response = response.json()
    # print(response)
    assert "jwt" in response and response.get("error") is None
    jwt_string = response.get("jwt")

    # test access with jwt 
    response = client.post("/get_data/", json={
        "jwt": jwt_string,
        "data_type": 1,
    })
    response = response.json()
    assert response.get("error") is None

    # test access with wrong jwt 
    response = client.post("/get_data/", json={
        "jwt": "asdhfashkjdsa.asgdsagdsa.asdgsagsad",
        "data_type": 1,
    })
    response = response.json()
    # print(response)
    assert response.get("error") is not None

    # test delete a user
    await myDatabase.deleteAUser(id=user_id)