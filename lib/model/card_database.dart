import 'package:shopping_card/model/card_model.dart';
import 'package:sqflite/sqflite.dart';
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

  Future<List<Cart>> getQueryList() async {
    Database? db = await database;

    List<Map<String, Object?>> queryList = await db!.query('cartTable');
    return queryList.map((e) => Cart.fromMap(e)).toList();
  }

  Future<int> deleteData(int id) async {
    Database? db = await database;
    return await db!.delete('cartTable', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateQuantity(Cart cart) async {
    Database? db = await database;
    return await db!.update(
      'cartTable',
      cart.toMap(),
      where: 'id = ?',
      whereArgs: [cart.id],
    );
  }
}
