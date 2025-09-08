import 'dart:async';

import 'package:note_cubit_grid/models/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note_model.dart';

class AppDataBase {
  AppDataBase._();

  static final AppDataBase instance = AppDataBase._();
  Database? database;

  static final String tableNAME = "tableNAME";
  static final String noteTITLE = "noteTITLE";
  static final String noteDESC = "noteDESC";
  static final String noteID = "noteID";

  /// user table
  static final String userTable = "userTable";
  static final String userName = "userName";
  static final String userId = "userId";
  static final String userPassword = "userPassword";
  static final String userEmail = "userEmail";

  ///Shared Prefs Keys
  static final String intKey = "Key";
  static final String login = "logged";
  static final String uName = "uName";

  Future<Database> initDb() async {
    var docDirectory = await getApplicationDocumentsDirectory();
    var dbPath = join(docDirectory.path, "notes.db");
    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE $tableNAME ( $noteID INTEGER PRIMARY KEY AUTOINCREMENT, $userId INTEGER, $noteTITLE TEXT, $noteDESC TEXT )",
        );
        db.execute(
          "CREATE TABLE $userTable( $userId INTEGER PRIMARY KEY AUTOINCREMENT, $userName TEXT, $userPassword TEXT, $userEmail TEXT )",
        );
      },
    );
  }

  Future<Database> getDB() async {
    if (database != null) {
      return database!;
    } else {
      database = await initDb();
      return database!;
    }
  }

  Future<bool> insertNote(NoteModel newNote) async {
    var uid = await getUID();
    newNote.user_id = uid;
    var db = await getDB();
    var res = await db.insert(tableNAME, newNote.toMap());
    return res > 0;
  }

  Future<bool> updateNote(NoteModel updateNote) async {
    var uid = await getUID();
    updateNote.user_id = uid;
    var db = await getDB();
    var res = await db.update(
      tableNAME,
      updateNote.toMap(),
      where: "$noteID = ?",
      whereArgs: [updateNote.note_id],
    );
    return res > 0;
  }

  Future<bool> deleteNote(int id) async {
    var db = await getDB();
    var res = await db.delete(tableNAME, where: "$noteID = ?", whereArgs: [id]);
    return res > 0;
  }

  Future<List<NoteModel>> fetchNotes() async {
    var uid = await getUID();
    var db = await getDB();
    List<NoteModel> arrNotes = [];
    var data = await db.query(
      tableNAME,
      where: "$userId = ?",
      whereArgs: [uid],
    );
    for (Map<String, dynamic> each in data) {
      var notes = NoteModel.fromMap(each);
      arrNotes.add(notes);
    }
    return arrNotes;
  }

  /// Authentication Operation

  // Login Operations
  Future<bool> authenticateUser(String email, String password) async {
    var db = await getDB();
    var data = await db.query(
      userTable,
      where: "$userEmail = ? and $userPassword = ?",
      whereArgs: [email, password],
    );

    if (data.isNotEmpty) {
      var prefs = await SharedPreferences.getInstance();
      prefs.setInt(intKey, UserModel.fromMap(data[0]).user_id);
      prefs.setBool(login, true);
      prefs.setString(uName, UserModel.fromMap(data[0]).user_name);
    }
    return data.isNotEmpty;
  }

  // SignUp Operation
  Future<bool> checkUserExisted(String email) async {
    var db = await getDB();
    var data = await db.query(
      userTable,
      where: "$userEmail = ?",
      whereArgs: [email],
    );
    return data.isNotEmpty;
  }

  Future<bool> createUser(UserModel newUser) async {
    var check = await checkUserExisted(newUser.user_email);
    if (!check) {
      var db = await getDB();
      await db.insert(userTable, newUser.toMap());
      return true;
    } else {
      return false;
    }
  }

  // get UserId

  Future<int> getUID() async {
    var prefs = await SharedPreferences.getInstance();
    var uid = prefs.getInt(intKey);
    return uid ?? 0;
  }

  Future<String> getUserName() async {
    var prefs = await SharedPreferences.getInstance();
    var userName = prefs.getString(uName);
    return userName ?? "";
  }


  Future<void> loggedOut() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(login, false);
  }
}
