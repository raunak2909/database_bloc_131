part of 'note_bloc.dart';

@immutable
abstract class NoteEvent {}

class AddNoteEvent extends NoteEvent{
  NoteModel newNote;
  AddNoteEvent({required this.newNote});
}

class FetchNoteEvent extends NoteEvent{}

class UpdateNoteEvent extends NoteEvent{
  NoteModel updateNote;
  UpdateNoteEvent({required this.updateNote});
}
