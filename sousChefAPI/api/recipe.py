# flask packages
from flask import Response, request, jsonify
from flask_restful import Resource
from flask_jwt_extended import jwt_required, get_jwt_identity

# project resources
from models.recipes import Recipes
from api.errors import forbidden


class RecipesApi(Resource):
    """
    Flask-resftul resource for returning db.recipes collection.
    :Example:
    >>> from flask import Flask
    >>> from flask_restful import Api
    >>> from app import default_config
    # Create flask app, config, and resftul api, then add RecipesApi route
    >>> app = Flask(__name__)
    >>> app.config.update(default_config)
    >>> api = Api(app=app)
    >>> api.add_resource(RecipesApi, '/recipe/')
    """

    @jwt_required
    def get(self) -> Response:
        """
        GET response method for all documents in recipe collection.
        JSON Web Token is required.
        :return: JSON object
        """
        output = Recipes.objects()
        return jsonify({'result': output})

    @jwt_required
    def post(self) -> Response:
        """
        POST response method for creating recipe.
        JSON Web Token is required.
        Authorization is required: Access(admin=true)
        :return: JSON object
        """
        authorized: bool = Recipes.objects.get(id=get_jwt_identity()).access.admin

        if authorized:
            data = request.get_json()
            post_user = Recipes(**data).save()
            output = {'id': str(post_user.id)}
            return jsonify({'result': output})
        else:
            return forbidden()


class RecipeApi(Resource):
    """
    Flask-resftul resource for returning db.Recipes collection.
    :Example:
    >>> from flask import Flask
    >>> from flask_restful import Api
    >>> from app import default_config
    # Create flask app, config, and resftul api, then add RecipeApi route
    >>> app = Flask(__name__)
    >>> app.config.update(default_config)
    >>> api = Api(app=app)
    >>> api.add_resource(RecipeApi, '/recipe/<recipe_id>')
    """

    @jwt_required
    def get(self, recipe_id: str) -> Response:
        """
        GET response method for single documents in recipe collection.
        :return: JSON object
        """
        output = Recipes.objects.get(id=recipe_id)
        return jsonify({'result': output})

    @jwt_required
    def put(self, recipe_id: str) -> Response:
        """
        PUT response method for updating a recipe.
        JSON Web Token is required.
        Authorization is required: Access(admin=true)
        :return: JSON object
        """
        data = request.get_json()
        put_user = Recipes.objects(id=recipe_id).update(**data)
        return jsonify({'result': put_user})

    @jwt_required
    def delete(self, user_id: str) -> Response:
        """
        DELETE response method for deleting single recipe.
        JSON Web Token is required.
        Authorization is required: Access(admin=true)
        :return: JSON object
        """
        authorized: bool = Recipes.objects.get(id=get_jwt_identity()).access.admin

        if authorized:
            output = Recipes.objects(id=user_id).delete()
            return jsonify({'result': output})
        else:
            return forbidden()
