import 'dart:io';
import 'package:path/path.dart' ;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tarc/ProductDB.dart';

class DBProvider {
	static Database _database;
	static final DBProvider db = DBProvider._();

	DBProvider._();

	Future<Database> get database async {
		// If database exists, return database
		if (_database != null) return _database;

		// If database don't exists, create one
		_database = await initDB();

		return _database;
	}

	initDB() async {
		Directory documentsDirectory = await getApplicationDocumentsDirectory();
		final path = join(documentsDirectory.path, 'wholeGrain.db');

		return await openDatabase(path, version: 1, onOpen: (db) {},
				onCreate: (Database db, int version) async {
					await db.execute('CREATE TABLE Product('
							'productName TEXT PRIMARY KEY,'
							'servingSize DOUBLE,'
							'totalWG_content_per_serving DOUBLE,'
							'totalWG_content DOUBLE,'
							'kcal_per_serving DOUBLE,'
							'total_fat DOUBLE,'
							'saturated_fat DOUBLE,'
							'monounsaturated_fat DOUBLE,'
							'polyunsaturated_fat DOUBLE,'
							'carbohydrate_double DOUBLE,'
							'fibre_double DOUBLE,'
							'total_sugar DOUBLE,'
							'protein_double DOUBLE,'
							'sodium_double DOUBLE,'
							'potassium_double DOUBLE,'
							'calcium_double DOUBLE,'
							'iron_double DOUBLE,'
							'image TEXT,'
							'referenceKey TEXT'
							')');
				});
	}

	Future<int> updateMenuItem(ProductDB productDB) async {
		var db = await this.database;
		var result = await db.update('Product', productDB.toJson(), where: 'productName = ?',
				whereArgs:
		[productDB.productName]);
		return result;
	}

	createMenuItem(ProductDB productDB) async {
		await deleteAllMenuItem();
		final db = await database;
		final res = await db.insert('Product', productDB.toJson());

		return res;
	}

	Future<int> deleteAllMenuItem() async {
		final db = await database;
		final res = await db.rawDelete('DELETE FROM Product');

		return res;
	}

	Future<List<ProductDB>> getMenuItem(String menuId) async {
		final db = await database;
		final res = await db.rawQuery("SELECT * FROM Product WHERE productName=\'" + menuId + "\'");

		List<ProductDB> list =
		res.isNotEmpty ? res.map((c) => ProductDB.fromJson(c)).toList() : [];

		return list;
	}

	Future<List<ProductDB>> getAllMenuItem() async {
		final db = await database;
		final res = await db.rawQuery("SELECT * FROM Product");

		List<ProductDB> list =
		res.isNotEmpty ? res.map((c) => ProductDB.fromJson(c)).toList() : [];

		return list;
	}
}