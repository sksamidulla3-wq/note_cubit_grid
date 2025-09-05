import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_cubit_grid/database/db.dart';
import 'package:note_cubit_grid/models/note_model.dart';

part 'notecubit_state.dart';

class NotecubitCubit extends Cubit<NotecubitState> {
  AppDataBase appDataBase;

  NotecubitCubit({required this.appDataBase}) : super(NotecubitInitialState());

  Future<void> addNote(NoteModel newNote) async {
    emit(NotecubitLoadingState());
    var check = await appDataBase.insertNote(newNote);
    if (check) {
      emit(NotecubitLoadedState(mData: await appDataBase.fetchNotes()));
    } else {
      emit(NotecubitErrorState(errorMsg: "Oop ! Something Went Wrong!"));
    }
  }

  Future<void> updateNotes(NoteModel updated) async {
    emit(NotecubitLoadingState());
    var check = await appDataBase.updateNote(updated);
    if (check) {
      emit(NotecubitLoadedState(mData: await appDataBase.fetchNotes()));
    } else {
      emit(NotecubitErrorState(errorMsg: "Oop ! Something Went Wrong!"));
    }
  }

  Future<void> deleteNotes(int id) async {
    emit(NotecubitLoadingState());
    var deleted = await appDataBase.deleteNote(id);
    if (deleted) {
      emit(NotecubitLoadedState(mData: await appDataBase.fetchNotes()));
    } else {
      emit(NotecubitErrorState(errorMsg: "Oop ! Something Went Wrong!"));
    }
  }

  Future<void> getAllNotes() async {
    emit(NotecubitLoadingState());
    emit(NotecubitLoadedState(mData: await appDataBase.fetchNotes()));
  }
}
