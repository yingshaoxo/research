import src.models as models
from datetime import datetime
import src.database.sqlite as sqlite
import src.auth as auth

async def run(myDatabase: sqlite.MyDatabase):
    myAuthClass = auth.MyAuthClass(myDatabase)

    # test delete all users
    await myDatabase.deleteAllUsers()

    # consts
    email = "yingshaoxo@gmail.com"
    username = "yingshaoxo"
    password = "password"

    # test with wrong email and password
    user_id = await myAuthClass.auth_username_and_password(email=email, password=password)
    assert user_id is None

    # create a new user
    user_id = await myDatabase.addAUser(aUser=models.User(
        email=email,
        username=username,
        password=password,
        create_at=datetime.now(),
        last_active_at=datetime.now(),
        is_superuser=False,
    ))
    assert user_id != None

    # test with right email and password
    user_id = await myAuthClass.auth_username_and_password(email=email, password=password)
    assert user_id is not None

    # test jwt
    jwt_string = await myAuthClass.get_auth_jwt_string(email=email, password=password)
    assert type(jwt_string) is str

    # auth with jwt
    new_user_id = await myAuthClass.auth_jwt_string(raw_jwt_string=jwt_string)
    assert new_user_id is not None
    assert new_user_id == user_id

    # auth with wrong jwt 1
    new_user_id = await myAuthClass.auth_jwt_string(raw_jwt_string="wrong_jwt_string")
    assert new_user_id is None

    # auth with wrong jwt 2
    new_user_id = await myAuthClass.auth_jwt_string(raw_jwt_string="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c")
    assert new_user_id is None

    # test delete a user
    await myDatabase.deleteAUser(id=user_id)

    # auth with jwt but the user is gone    
    new_user_id = await myAuthClass.auth_jwt_string(raw_jwt_string=jwt_string)
    assert new_user_id is None

    # test list users
    user_list = await myDatabase.listUsers()
    assert len(user_list) == 0


