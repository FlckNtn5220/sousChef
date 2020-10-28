import mongoengine


class Items(mongoengine.EmbeddedDocument):
    name = mongoengine.StringField(required=True)
