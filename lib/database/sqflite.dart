import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDatabase{
  
  static Database? _db;
  //done create once
  Future<Database?> get db async{
    if(_db == null){
      _db = await intialDb();
      return _db;
    }else{
      return _db;
    }
  }
  intialDb()async{
    String databasePath = await getDatabasesPath();
    String path = join(databasePath , 'App.db');
    Database db = await openDatabase( path , onCreate: _onCreate, version: 1);
    return db;
  }
  
  _onCreate(Database db , int version)async{
    await db.execute('''
      CREATE TABLE "request" (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        name TEXT, phonenumber TEXT, date TEXT
      )
    '''
    );
    print('Create Database Successfully =========');
  }

  readData(String sql)async{
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }
  InsertData(String sql)async{
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }
  updateData(String sql)async{
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }
  deleteData(String sql)async{
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

}