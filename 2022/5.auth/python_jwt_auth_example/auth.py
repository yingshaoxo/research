import re
import jwt


secret = "secret is a secret"


many_users = {
    '1': {
        'username': 'joe',
        'password': 'password',
        'age': '25',
        'occupation': 'student'
    },
    '2': {
        'name': 'yingshaoxo',
        'password': 'password',
        'age': '24',
        'occupation': 'student'
    },
}


def auth_username_and_password(username: str, password: str):
    for id, user in many_users.items():
        if user['username'] == username and user['password'] == password:
            return id
    return None


def encode_jwt(payload):
    return jwt.encode(payload, secret, algorithm='HS256')


def decode_jwt(raw_string):
    return jwt.decode(raw_string, secret, algorithms=['HS256'])


def regex_validate_for_jwt(raw_string):
    return bool(re.match(r'^[a-zA-Z0-9\-_]+?\.[a-zA-Z0-9\-_]+?\.([a-zA-Z0-9\-_]+)?$', raw_string))

# jwt: JSON Web Token
def auth_jwt_string(raw_jwt_string):
    if not regex_validate_for_jwt(raw_jwt_string):
        return False

    object = decode_jwt(raw_jwt_string)
    id = object.get('id')
    if id in many_users:
        return True
    else:
        return False


def get_auth_jwt_string(id: str):
    return encode_jwt({'id': id})