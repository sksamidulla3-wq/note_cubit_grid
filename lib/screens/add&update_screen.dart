import 'package:flutter/material.dart';

class AddUpdatePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note Here.."),
      ),
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: "Title",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.pink),
              ),
              focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.pink),
              ),
            ),
          ),
          TextField(
            controller: contentController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: "Content",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.pink),
              ),
              focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.pink),
              ),
            ),
          ),
          Row(
            children: [
              ElevatedButton(onPressed: (){}, child: Text("Save")),
              ElevatedButton(onPressed: (){}, child: Text("Cancel")),
            ],
          )
        ],
      ),
    );
  }
}