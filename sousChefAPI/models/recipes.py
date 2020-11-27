# mongo-engine packages
from mongoengine import *

# project resources
from models.items import Items

class Recipes(Document):
    """
    Template for a mongoengine document, which represents user recipes.
    :param name: required string value
    :param description: optional string valu
    :param items: required List of Items
    :param favorite: optional boolean value
    :Example:
    >>> import mongoengine
    >>> from app import default_config
    >>> mongoengine.connect(**default_config['MONGODB_SETTINGS'])
    MongoClient(host=['localhost:27017'], document_class=dict, tz_aware=False, connect=True, read_preference=Primary())
    >>> new_recipe = Recipes(name= "Vegetable Spring Rolls", \
                        description= "These crisp veggie rolls are filled with"  \
                                     "cabbage, peppers, cucumber, and home-made peanut sauce.", \
                                     items= ['{"name": "peanuts"}, {"name": "butter"}'] \
                                     favorite = true)
    >>> new_recipe.save()
    """

    name = StringField(required=True)
    description = StringField()
    items = ListField(ReferenceField(Items), required = True)
    favorite = BooleanField()
