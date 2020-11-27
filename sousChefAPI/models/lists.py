# mongo-engine packages
from mongoengine import *

# project resources
from models.items import Items


class Lists(Document):
    """
    Template for a mongoengine document, which represents user lists.
    :param name: required string value
    :param items: required List of Items
    :param favorite: optional boolean value
    :Example:
    >>> import mongoengine
    >>> from app import default_config
    >>> mongoengine.connect(**default_config['MONGODB_SETTINGS'])
    MongoClient(host=['localhost:27017'], document_class=dict, tz_aware=False, connect=True, read_preference=Primary())
    >>> new_list = Lists(name= "Vegetable Spring Rolls", \
                        items= [{"name": "Apple"}, {"name": "Grapefruit"}] \
                        favorite = "True")
    >>> new_list.save()
    <Meal: Meal object>
    """

    name = StringField(required=True)
    items = ListField(ReferenceField(Items), required=True)
    favorite = BooleanField()
