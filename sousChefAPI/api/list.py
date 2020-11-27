# flask packages
from flask import Response, request, jsonify
from flask_restful import Resource
from flask_jwt_extended import jwt_required, get_jwt_identity

# project resources
from models.lists import Lists
from api.errors import forbidden


class ListsApi(Resource):
    """
    Flask-resftul resource for returning db.lists collection.
    :Example:
    >>> from flask import Flask
    >>> from flask_restful import Api
    >>> from app import default_config
    # Create flask app, config, and resftul api, then add ListsApi route
    >>> app = Flask(__name__)
    >>> app.config.update(default_config)
    >>> api = Api(app=app)
    >>> api.add_resource(ListsApi, '/list/')
    """
    @jwt_required
    def get(self) -> Response:
        """
        GET response method for all documents in list collection.
        JSON Web Token is required.
        :return: JSON object
        """
        output = Lists.objects()
        return jsonify({'result': output})

    @jwt_required
    def post(self) -> Response:
        """
        POST response method for creating list.
        JSON Web Token is required.
        Authorization is required: Access(admin=true)
        :return: JSON object
        """
        authorized: bool = Lists.objects.get(id=get_jwt_identity()).access.admin

        if authorized:
            data = request.get_json()
            post_user = Lists(**data).save()
            output = {'id': str(post_user.id)}
            return jsonify({'result': output})
        else:
            return forbidden()


class ListApi(Resource):
    """
    Flask-resftul resource for returning db.List collection.
    :Example:
    >>> from flask import Flask
    >>> from flask_restful import Api
    >>> from app import default_config
    # Create flask app, config, and resftul api, then add ListApi route
    >>> app = Flask(__name__)
    >>> app.config.update(default_config)
    >>> api = Api(app=app)
    >>> api.add_resource(ListApi, '/list/<list_id>')
    """
    @jwt_required
    def get(self, list_id: str) -> Response:
        """
        GET response method for single documents in list collection.
        :return: JSON object
        """
        output = Lists.objects.get(id=list_id)
        return jsonify({'result': output})

    @jwt_required
    def put(self, list_id: str) -> Response:
        """
        PUT response method for updating a list.
        JSON Web Token is required.
        Authorization is required: Access(admin=true)
        :return: JSON object
        """
        data = request.get_json()
        put_user = Lists.objects(id=list_id).update(**data)
        return jsonify({'result': put_user})

    @jwt_required
    def delete(self, user_id: str) -> Response:
        """
        DELETE response method for deleting single list.
        JSON Web Token is required.
        Authorization is required: Access(admin=true)
        :return: JSON object
        """
        authorized: bool = Lists.objects.get(id=get_jwt_identity()).access.admin

        if authorized:
            output = Lists.objects(id=user_id).delete()
            return jsonify({'result': output})
        else:
            return forbidden()