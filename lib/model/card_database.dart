import 'package:shopping_card/model/card_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class CardDataBase {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    String directory = await getDatabasesPath();

    String path = join(directory, 'database.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE cartTable(
        id INTEGER PRIMARY KEY,
        productsId VARCHAR UNIQUE,
        productsName TEXT,
        initialPrice INTEGER,
        productPrice INTEGER,
        quantity INTEGER,
        unitTag TEXT,
        image TEXT
        )
        ''');
      },
    );
    return _database;
  }

  Future<Cart> insertData(Cart cart) async {
    Database? db = await database;
    await db!.insert('cartTable', cart.toMap());
    return cart;
  }
}
