import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../database/app_database.dart';
import '../models/note_model.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  AppDataBase db;
  NoteBloc({required this.db}) : super(NoteInitialState()) {

    ///(to add new note) event handling
    on<AddNoteEvent>((event, emit) async{
      emit(NoteLoadingState());
      bool check = await db.addNote(event.newNote);
      if(check){
        var mArrNotes = await db.fetchAllNotes();
        emit(NoteLoadedState(arrNotes: mArrNotes));
      } else {
        emit(NoteErrorState(errorMsg: "Note not Added!!"));
      }
    });


    ///(get all notes) event handling
    on<FetchNoteEvent>((noteEvent, myEmit) async{
      myEmit(NoteLoadingState());
      var mArrNotes = await db.fetchAllNotes();
      myEmit(NoteLoadedState(arrNotes: mArrNotes));
    });

    ///(update note) event handling
    on<UpdateNoteEvent>((event, emit) async{
      emit(NoteLoadingState());
      bool check = await db.updateNote(event.updateNote);

      if(check){
        var mData = await db.fetchAllNotes();
        emit(NoteLoadedState(arrNotes: mData));
      } else {
        emit(NoteErrorState(errorMsg: "Note Not Updated!!"));
      }
    });
  }
}
