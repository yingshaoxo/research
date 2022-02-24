import sys
import uvicorn

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

import utils
import models
import auth


app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@ app.get("/", response_model=str)
async def hi():
    return "Hello, World!"


@ app.post("/login/", response_model=models.LoginOutput)
async def login(data: models.LoginInput):
    user_id = auth.auth_username_and_password(data.username, data.password)

    if user_id is None:
        return {
            "result": "",
            "error": "Invalid username or password"
        }

    return {
        "result": {
            "token": auth.get_auth_jwt_string(user_id)
        },
        "error": None
    }


@ app.post("/get_data/", response_model=models.GetDataOutput)
async def get_data(data: models.GetDataInput):
    isValid = auth.auth_jwt_string(data.token)
    if isValid:
        return {
            "data": "Hi, you can get my data because you are one of my users!",
            "error": None
        }

    return {
        "data": "No! You can't get anything from me! You are not my users!",
        "error": "Invalid token"
    }


def start():
    # launch with: poetry run dev

    port = sys.argv[-1]
    if port.isdigit():
        port = int(port)
    else:
        port = 8000

    while utils.is_port_in_use(port):
        port += 1

    print(f"\n\n\nThe service is running on: http://localhost:{port}\n\n")

    uvicorn.run("main:app", host="0.0.0.0",
                port=port, debug=True, reload=True, workers=1)