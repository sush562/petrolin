import 'package:flutter/widgets.dart';
import 'package:petrolin/data/datasource/database/fuel_database.dart';
import 'package:petrolin/data/datasource/entity/fuel_entity.dart';
import 'package:petrolin/domain/model/fuel_entry.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FuelDatabaseImpl extends FuelDatabase {
  static const _databaseName = 'fuel_database';
  static const _fuelAddTableName = 'fuel_add_table';
  static const _currentFuelPriceTableName = 'current_fuel_cost_table';
  static const _databaseVersion = 1;

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  //Fuel Entry
  @override
  Future<int> insertFuelEntry(FuelEntryEntity row) async {
    final db = await database;
    return await db.insert(_fuelAddTableName, row);
  }

  @override
  Future<void> deleteFuelEntry(int id) async {
    final db = await database;
    await db.delete(_fuelAddTableName,
        where: '${FuelEntry.columnId} = ?', whereArgs: [id]);
  }

  @override
  Future<FuelEntryListEntity> getAllFuelEntries() async {
    final db = await database;
    final FuelEntryListEntity response = await db.query(_fuelAddTableName,
        orderBy: '${FuelEntry.columnEntryTime} DESC');
    return response;
  }

  @override
  Future<FuelEntryEntity?> getFuelEntry(int id) async {
    final db = await database;
    final FuelEntryListEntity responseList = await db.query(_fuelAddTableName,
        where: '${FuelEntry.columnId} = ?', whereArgs: [id]);
    FuelEntryEntity? response;
    if (responseList.isNotEmpty) {
      response = responseList[0];
    }
    return response;
  }

  @override
  Future<double> getSumOfFuelCost() async {
    final db = await database;
    var result = await db.rawQuery(
        'SELECT SUM(${FuelEntry.columnFuelCost}) as total FROM $_fuelAddTableName');
    final totalResult = result.first['total'];
    double total = totalResult == null ? 0.0 : totalResult as double;
    return total;
  }

  @override
  Future<int> updateFuelEntry(int id, FuelEntryEntity row) async {
    final db = await database;
    return db.update(_fuelAddTableName, row,
        where: '${FuelEntry.columnId} = ?',
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Fuel price
  Future<int> insertCurrentFuelPrice(FuelEntryEntity row) async {
    final db = await database;
    return await db.insert(_currentFuelPriceTableName, row);
  }

  Future<void> deleteCurrentFuelPrice(int id) async {
    final db = await database;
    await db.delete(_currentFuelPriceTableName,
        where: '${FuelEntry.columnId} = ?', whereArgs: [id]);
  }

  Future<Database> _initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(join(await getDatabasesPath(), _databaseName),
        onCreate: (db, _) {
      db.execute('''
          CREATE TABLE $_fuelAddTableName(
            ${FuelEntry.columnId} INTEGER PRIMARY KEY,
            ${FuelEntry.columnFuelCost} REAL NOT NULL,
            ${FuelEntry.columnFuelType} TEXT NOT NULL,
            ${FuelEntry.columnEntryTime} TEXT NOT NULL
          )
      ''');
      db.execute('''
          CREATE TABLE $_currentFuelPriceTableName(
            ${FuelEntry.columnId} INTEGER PRIMARY KEY,
            ${FuelEntry.columnFuelCost} REAL NOT NULL,
            ${FuelEntry.columnFuelType} TEXT NOT NULL,
            ${FuelEntry.columnEntryTime} TEXT NOT NULL
          )
      ''');
    }, version: _databaseVersion);
  }
}
