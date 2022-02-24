from __future__ import annotations
from datetime import datetime

from typing import Optional, Any
from pydantic import BaseModel

#
# general models
#

class User(BaseModel):
    id: Optional[int] = None
    email: str
    username: str
    password: str
    create_at: datetime
    last_active_at: datetime
    is_superuser: bool


#
# models for restful api
#

class registerUserInput(BaseModel):
    email: str
    username: str
    password: str


class registerUserOutput(BaseModel):
    user_id: Optional[int]
    error: Optional[str]


class LoginInput(BaseModel):
    email: str
    password: str


class LoginOutput(BaseModel):
    jwt: Optional[str]
    error: Optional[str]



class JWTBaseModel(BaseModel):
    jwt: str


class GetDataInput(JWTBaseModel):
    data_type: int


class GetDataOutput(BaseModel):
    data: str
    error: Optional[str]