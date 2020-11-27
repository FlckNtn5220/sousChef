# mongo-engine packages
from mongoengine import *


class Items(Document):
    """
    Template for a mongoengine document, which represents user recipes.
    :param name: required string value
    """


name = StringField(required=True)
