from datetime import datetime
import sys
import uvicorn

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

import src.config as config
import src.utils as utils
import src.models as models
import src.auth as auth
import src.database.sqlite as sqlite


myDatabase = sqlite.MyDatabase(DATABASE_URL=config.DATABASE_URL)
myAuthClass = auth.MyAuthClass(myDatabase)


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


@app.post("/register/", response_model=models.registerUserOutput)
async def register(registerUserInput: models.registerUserInput):
    user_id = await myDatabase.addAUser(aUser=models.User(
        email=registerUserInput.email,
        username=registerUserInput.username,
        password=registerUserInput.password,
        create_at=datetime.now(),
        last_active_at=datetime.now(),
        is_superuser=False,
    ))
    if user_id is not None:
        return models.registerUserOutput(
            user_id=user_id,
            error=None
        )
    else:
        return models.registerUserOutput(
            user_id=None,
            error="Error: User already exists",
        )


@ app.post("/login/", response_model=models.LoginOutput)
async def login(data: models.LoginInput):
    user = await myDatabase.checkIfUserExistByEmailAndPassword(email=data.email, password=data.password)
    if user is None:
        return {
            "jwt": None,
            "error": "Invalid username or password"
        }

    return {
        "jwt": await myAuthClass.get_auth_jwt_string(email=data.email, password=data.password),
        "error": None
    }


@ app.post("/get_data/", response_model=models.GetDataOutput)
async def get_data(data: models.GetDataInput):
    isValid = await myAuthClass.auth_jwt_string(data.jwt)
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

    uvicorn.run("src.main:app", host="0.0.0.0",
                port=port, debug=True, reload=True, workers=1)