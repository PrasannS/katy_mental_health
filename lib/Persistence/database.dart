import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:katy_mental_health/Models/entry.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String entryTable = 'entry_table';
  String colId = 'id';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'appdb.db';

    // Open/create the database at a given path
    var entrysDatabase = await openDatabase(path, version: 3, onCreate: _createDb);
    return entrysDatabase;
  }

  //int    id;
  //int    sleep;
  //int    mood;
  //int    water;
  //int    questionId;
  //String answer;
  //String note;

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE entry_table(id INTEGER PRIMARY KEY AUTOINCREMENT, sleep INTEGER, '
        'mood INTEGER, water INTEGER, question_id INTEGER, answer TEXT, note TEXT, activity TEXT, datetime TEXT)');

  }

  // Fetch Operation: Get all entry objects from database
  Future<List<Map<String, dynamic>>> getEntryMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $entryTable order by $colPriority ASC');
    var result = await db.query(entryTable, orderBy: '$colId ASC');
    return result;
  }

  // Insert Operation: Insert a Entry object to database
  Future<int> insertEntry(Entry entry) async {
    Database db = await this.database;
    var result = await db.insert(entryTable, entry.toMap());
    print(result);
    return result;
  }

  // Update Operation: Update a Entry object and save it to database
  Future<int> updateEntry(Entry entry) async {
    var db = await this.database;
    var result = await db.update(entryTable, entry.toMap(), where: '$colId = ?', whereArgs: [entry.id]);
    return result;
  }

  // Delete Operation: Delete a Entry object from database
  Future<int> deleteEntry(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $entryTable WHERE $colId = $id');
    return result;
  }

  // Get number of Entry objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $entryTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Entry List' [ List<Entry> ]
  Future<List<Entry>> getEntryList() async {

    var entryMapList = await getEntryMapList(); // Get 'Map List' from database
    int count = entryMapList.length;         // Count the number of map entries in db table

    List<Entry> entryList = List<Entry>();
    // For loop to create a 'Entry List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      entryList.add(Entry.fromMap(entryMapList[i]));
    }

    return entryList;
  }

}