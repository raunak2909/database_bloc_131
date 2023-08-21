import 'package:database_bloc_131/bloc/note_bloc.dart';
import 'package:database_bloc_131/models/note_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNotePage extends StatelessWidget{
  var titleController = TextEditingController();
  var descController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
      ),
      body: Container(
          height: 400,
          child: Column(children: [
            Text("Add Note", style: TextStyle(fontSize: 21)),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  hintText: 'Enter Title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21.0))),
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(
                  hintText: 'Enter Desc',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21.0))),
            ),
            ElevatedButton(
                child: Text("Add Note"),
                onPressed: () {
                  var title = titleController.text.toString();
                  var desc = descController.text.toString();

                  context.read<NoteBloc>().add(AddNoteEvent(newNote: NoteModel(title: title, desc: desc)));

                  Navigator.pop(context);
                }),
          ])),
    );
  }
}