import '../database/db.dart';

class NoteModel {
  String note_title;
  String note_desc;
  int note_id;
  int user_id;

  NoteModel({
    required this.note_title,
    required this.note_desc,
    required this.note_id,
    required this.user_id,
  });

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      note_title: map[AppDataBase.noteTITLE],
      note_desc: map[AppDataBase.noteDESC],
      note_id: map[AppDataBase.noteID],
      user_id: map[AppDataBase.userId],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      AppDataBase.noteTITLE: note_title,
      AppDataBase.noteDESC: note_desc,
      AppDataBase.userId: user_id,
    };
  }
}
