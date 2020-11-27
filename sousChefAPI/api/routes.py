 #flask packages
from flask_restful import Api

# project resources
from api.authentication import SignUpApi, LoginApi
from api.user import UsersApi, UserApi
from api.recipe import RecipesApi, RecipeApi
from api.list import ListsApi, ListApi
from api.item import ItemsApi, ItemApi


def create_routes(api: Api):
    """Adds resources to the api.
    :param api: Flask-RESTful Api Object
    :Example:
        api.add_resource(HelloWorld, '/', '/hello')
        api.add_resource(Foo, '/foo', endpoint="foo")
        api.add_resource(FooSpecial, '/special/foo', endpoint="foo")
    """
    api.add_resource(SignUpApi, '/authentication/signup/')
    api.add_resource(LoginApi, '/authentication/login/')

    api.add_resource(UsersApi, '/user/')
    api.add_resource(UserApi, '/user/<user_id>')

    api.add_resource(RecipesApi, '/recipe/')
    api.add_resource(RecipeApi, '/recipe/<recipe_id>')

    api.add_resource(ListsApi, '/list/')
    api.add_resource(ListApi, '/list/<list_id>')

    api.add_resource(ItemsApi, '/item/')
    api.add_resource(ItemApi, '/item/<item_id>')