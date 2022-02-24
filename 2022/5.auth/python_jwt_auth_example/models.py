from ctypes import Union
from lib2to3.pytree import Base
from typing import Optional, Any
from pydantic import BaseModel

class LoginInput(BaseModel):
    username: str
    password: str


class LoginOutput(BaseModel):
    result: Optional[Any]
    error: Optional[str]


class JWTBaseModel(BaseModel):
    token: str


class GetDataInput(JWTBaseModel):
    data_type: int


class GetDataOutput(BaseModel):
    data: str
    error: Optional[str]