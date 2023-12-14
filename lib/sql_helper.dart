import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'StockItem.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        price REAL NOT NULL,
        category TEXT NOT NULL,
        warehouse TEXT NOT NULL
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('dbstock.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createItem({
    required String name,
    required int quantity,
    required double price,
    required String category,
    required String warehouse,
  }) async {
    final db = await SQLHelper.db();
    final data = {
      'name': name,
      'quantity': quantity,
      'price': price,
      'category': category,
      'warehouse': warehouse,
    };
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: "id = ? ", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(StockItem item) async {
    final db = await SQLHelper.db();

    final data = {
      'name': item.name,
      'quantity': item.quantity,
      'price': item.price,
      'category': item.category,
      'warehouse': item.warehouse,
    };

    final result = await db.update(
      'items',
      data,
      where: 'id = ?',
      whereArgs: [item.id],
    );

    return result;
  }

  static Future<bool> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('items', where: 'id = ?', whereArgs: [id]);
      return true; // Deletion successful
    } catch (err) {
      debugPrint("Error deleting item: $err");
      return false; // Deletion failed
    }
  }
}
