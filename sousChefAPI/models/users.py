# mongo-engine packages
from mongoengine import *

# flask packages
from flask_bcrypt import generate_password_hash, check_password_hash

# project resources
from models.recipes import Recipes
from models.lists import Lists

# external packages
import re


class Access(EmbeddedDocument):
    """
    Custom EmbeddedDocument to set user authorizations.
    :param user: boolean value to signify if user is a user
    :param admin: boolean value to signify if user is an admin
    """
    user = BooleanField(default=True)
    admin = BooleanField(default=False)


class Users(Document):
    """
    Template for a mongoengine document, which represents a user.
    Password is automatically hashed before saving.
    :param firstName: required string value
    :param lastName: required string value
    :param username: unique required string value
    :param password: required string value, longer than 6 characters
    :param access: Access object
    :param fav_lists: List of Lists objects
    :param fav_recipes: List of Recipe objects

    :Example:
    >>> import mongoengine
    >>> from app import default_config
    >>> mongoengine.connect(**default_config['MONGODB_SETTINGS'])
    MongoClient(host=['localhost:27017'], document_class=dict, tz_aware=False, connect=True, read_preference=Primary())
    # Create test user
    >>> new_user = Users(username = "Alex1234", password="hunter2", access={"admin": True})
    >>> new_user.save()
    >>> new_user.name = "spammy"
    >>> new_user.save()
    # Remove test user
    >>> new_user.delete()
    .. seealso:: :class:`Access`
    """

    firstName = StringField(required=True)
    lastName = StringField(required=True)
    username = StringField(required=True, unique=True)
    password = StringField(required=True, min_length=6, regex=None)
    access = EmbeddedDocumentField(Access, default=Access(user=True, admin=False))
    fav_lists = ListField(ReferenceField(Lists))
    fav_recipes = ListField(ReferenceField(Recipes))

    def generate_pw_hash(self):
        self.password = generate_password_hash(password=self.password).decode('utf-8')

    # Use documentation from BCrypt for password hashing
    generate_pw_hash.__doc__ = generate_password_hash.__doc__

    def check_pw_hash(self, password: str) -> bool:
        return check_password_hash(pw_hash=self.password, password=password)

    # Use documentation from BCrypt for password hashing
    check_pw_hash.__doc__ = check_password_hash.__doc__

    def save(self, *args, **kwargs):
        # Overwrite Document save method to generate password hash prior to saving
        self.generate_pw_hash()
        super(Users, self).save(*args, **kwargs)
