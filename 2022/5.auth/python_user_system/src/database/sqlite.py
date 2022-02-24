from typing import Optional
import databases
import sqlalchemy

import src.models as models


class MyDatabase:
    def __init__(self, DATABASE_URL: str) -> None:
        self.database = databases.Database(DATABASE_URL)
        self.metadata = sqlalchemy.MetaData()

        self.users_table = sqlalchemy.Table(
            "users",
            self.metadata,
            sqlalchemy.Column("id", sqlalchemy.Integer, primary_key=True),
            sqlalchemy.Column("email", sqlalchemy.String),
            sqlalchemy.Column("username", sqlalchemy.String),
            sqlalchemy.Column("password", sqlalchemy.String),
            sqlalchemy.Column("create_at", sqlalchemy.DateTime),
            sqlalchemy.Column("last_active_at", sqlalchemy.DateTime),
            sqlalchemy.Column("is_superuser", sqlalchemy.Boolean),
        )

        self.engine = sqlalchemy.create_engine(
            DATABASE_URL, connect_args={"check_same_thread": False}
        )

        self.metadata.create_all(self.engine)

    async def checkIfUserExistByEmailAndPassword(self, email: str, password: str) -> Optional[models.User]:
        query = self.users_table.select().where((self.users_table.c.email == email) & (self.users_table.c.password == password))
        user = await self.database.fetch_one(query)
        if user is None:
            return None
        return models.User(**user)

    async def addAUser(self, aUser: models.User) -> int:
        query = self.users_table.insert().values(**aUser.dict())
        the_new_user_id = await self.database.execute(query)
        if the_new_user_id is not None:
            return the_new_user_id
        return None
    
    async def updateAUser(self, id: int, aUser: models.User) -> bool:
        # do not know if this is working
        old_user = await self.getAUser(id=id)
        old_user_dict = old_user.dict()
        old_user_dict.update(aUser.dict())

        query = self.users_table.update().where(
            self.users_table.c.id == id
        ).values(**old_user_dict)

        return await self.database.execute(query) is not None
    
    async def getAUser(self, id: int) -> Optional[models.User]:
        query = self.users_table.select().where(self.users_table.c.id == id)
        user = await self.database.fetch_one(query)
        if user is None:
            return None
        return models.User(**user)
    
    async def listUsers(self) -> list[models.User]:
        query = self.users_table.select()
        users = await self.database.fetch_all(query)
        return [models.User(**user) for user in users]
    
    async def deleteAUser(self, id: int) -> bool:
        query = self.users_table.delete().where(self.users_table.c.id == id)
        return await self.database.execute(query) is not None

    async def deleteAllUsers(self) -> bool:
        query = self.users_table.delete()
        return await self.database.execute(query) is not None

    # async def getAProjectByID(self, projectID: int) -> ProjectOutput:
    #     query = self.projects.select().where(self.projects.c.id == projectID)
    #     return await self.database.fetch_one(query)

    # async def updateOutputOfAProject(
    #     self, projectID: int, output: str
    # ) -> ProjectOutput:
    #     query = self.projects.update().where(
    #         self.projects.c.id == projectID
    #     ).values(output=output)
    #     await self.database.execute(query)

    #     return await self.getAProjectByID(projectID)

    # async def setStatusOfAProject(self, projectID: int, status: int) -> ProjectOutput:
    #     query = self.projects.update().where(
    #         self.projects.c.id == projectID
    #     ).values(status=status)
    #     await self.database.execute(query)

    #     return await self.getAProjectByID(projectID)

    # async def getProjectByInputOrOutputFilePath(self, filePath: str) -> ProjectOutput:
    #     query = self.projects.select().where((self.projects.c.output == filePath) | (self.projects.c.input == filePath))
    #     return await self.database.fetch_one(query)
