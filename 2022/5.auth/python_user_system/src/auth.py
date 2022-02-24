import re
import jwt

import src.config as config
import src.database.sqlite as sqlite
from typing import Optional, Any


class MyAuthClass:
    def __init__(self, database: sqlite.MyDatabase):
        self.myDatabase = database


    async def auth_username_and_password(self, email: str, password: str) -> int:
        user = await self.myDatabase.checkIfUserExistByEmailAndPassword(email=email, password=password)
        if (not user):
            return None
        return user.id


    def encode_jwt(self, payload):
        return jwt.encode(payload, config.SECRET, algorithm='HS256')


    def decode_jwt(self, raw_string):
        return jwt.decode(raw_string, config.SECRET, algorithms=['HS256'])


    def regex_validate_for_jwt(self, raw_string):
        return bool(re.match(r'^[a-zA-Z0-9\-_]+?\.[a-zA-Z0-9\-_]+?\.([a-zA-Z0-9\-_]+)?$', raw_string))

    # jwt: JSON Web Token
    async def auth_jwt_string(self, raw_jwt_string) -> Optional[int]:
        if not self.regex_validate_for_jwt(raw_jwt_string):
            return None

        try: 
            object = self.decode_jwt(raw_jwt_string)
        except Exception as e:
            return None

        email = object.get('email')
        password = object.get('password')

        user_id = await self.auth_username_and_password(email=email, password=password)
        if user_id is not None:
            return user_id
        else:
            return None


    async def get_auth_jwt_string(self, email: str, password: str) -> str:
        return self.encode_jwt({'email': email, 'password': password})