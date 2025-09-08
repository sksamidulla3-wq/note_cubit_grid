import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_cubit_grid/cubit/notecubit_cubit.dart';
import 'package:note_cubit_grid/models/note_model.dart';


class AddUpdatePage extends StatelessWidget {
  final bool isEdit;
  final NoteModel? notes;

  AddUpdatePage({required this.isEdit, this.notes});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();
    if (isEdit && notes != null) {
      titleController.text = notes!.note_title;
      contentController.text = notes!.note_desc;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Note Here..." : "Add Note Here.."),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Title",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.pink),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.pink),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: contentController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Content",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.pink),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.pink),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final userId = await context
                        .read<NotecubitCubit>()
                        .appDataBase
                        .getUID();
                    if (!isEdit) {
                      // ADD NEW NOTE
                      context.read<NotecubitCubit>().addNote(
                        NoteModel(
                          note_title: titleController.text,
                          note_desc: contentController.text,
                          note_id: 0,
                          user_id: userId
                        ),
                      );
                    } else {
                      // UPDATE EXISTING NOTE
                      if (notes != null) {
                        context.read<NotecubitCubit>().updateNotes(
                          NoteModel(
                            note_title: titleController.text,
                            note_desc: contentController.text,
                            note_id: notes!.note_id,
                            user_id: notes!.user_id,
                          ),
                        );
                      }
                    }
                    Navigator.pop(context);
                  },
                  child: Text(isEdit ? "Edit" : "Save"),
                ),

                ElevatedButton(onPressed: () {}, child: Text("Cancel")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
