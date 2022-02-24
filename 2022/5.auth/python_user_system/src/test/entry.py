import asyncio
from fastapi.testclient import TestClient
from src.main import app
import src.test.test_database as test_database
import src.test.test_user_system as test_user_system
import src.test.test_restful_api as test_restful_api

import src.database.sqlite as sqlite
import src.config as config

client = TestClient(app)
myDatabase = sqlite.MyDatabase(DATABASE_URL=config.DATABASE_URL)

async def async_function():
    await test_database.run(myDatabase=myDatabase)
    await test_user_system.run(myDatabase=myDatabase)
    await test_restful_api.run(myDatabase=myDatabase, client=client)

def main():
    # loop = asyncio.get_event_loop()
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    loop.run_until_complete(async_function())