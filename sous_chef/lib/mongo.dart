import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_dart/mongo_dart.dart' as dart_mongo;

main(List<String> arguments) async {
  Db db = Db(
      'mongodb+srv://Payne5220:Knights2020@softwareeng.1ub3g.mongodb.net/sousChef?retryWrites=true&w=majority');
  await db.open();
  print('Connected to database');
}
