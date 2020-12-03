import 'package:mongo_dart/mongo_dart.dart';
import 'package:sevr/sevr.dart';

void start() async {
  //Login to DB
  final db = await Db.create(
      'mongodb+srv://Payne5220:Knights2020@softwareeng.1ub3g.mongodb.net/sousChef?retryWrites=true&w=majority');
  await db.open();
  final coll = db.collection('Recipes');

  //Create server
  const port = 8081;
  final serv = Sevr();

  serv.get('/', [
    (ServRequest req, ServResponse res) async {
      final recipes = await coll.find().toList();
      return res.status(200).json({'Recipes': recipes});
    }
  ]);

  serv.post('/', [
    (ServRequest req, ServResponse res) async {
      await coll.save(req.body);
      return res.json(await coll.findOne(where.eq('name', req.body['name'])));
    }
  ]);

  serv.delete('/:id', [
    (ServRequest req, ServResponse res) async {
      await coll
          .remove(where.eq('_id', ObjectId.fromHexString(req.params['id'])));
      return res.status(200);
    }
  ]);

  //Listen for connections
  serv.listen(port, callback: () {
    print('Server listening on port: $port');
  });
}
