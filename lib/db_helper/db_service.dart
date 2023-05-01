import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:inware_task_app/model/product_model.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DbService {
  static const int _version = 4;
  static const String _dbName = 'Product.db';

  static Future<Database> _getDbService() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async =>
          await db.execute('''CREATE TABLE ProductModel(
      id TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      imageUrl TEXT,
      type TEXT NOT NULL,
      number TEXT NOT NULL,
      cost TEXT NOT NULL,
      count TEXT NOT NULL)'''),
      version: _version,
    );
  }

  ///aaaa
  static Future<int?> addProduct(ProductModel product) async {
    try {
      final db = await _getDbService();
      return await db.insert('ProductModel', product.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  static Future<int?> updateProduct(ProductModel product) async {
    try {
      final db = await _getDbService();
      return await db.update('ProductModel', product.toJson(),
          where: "id = ?",
          whereArgs: [product.id],
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  static Future<int?> deleteProduct(ProductModel product) async {
    try {
      final db = await _getDbService();
      return await db.delete(
        'ProductModel',
        where: 'id = ?',
        whereArgs: [product.id],
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  static Future<List<ProductModel>?> getAllProduct() async {
    try {
      final db = await _getDbService();
      final List<Map<String, dynamic>> maps = await db.query('ProductModel');

      if (maps.isEmpty) {
        return null;
      }
      return List.generate(
          maps.length, (index) => ProductModel.fromJson(maps[index]));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

}
