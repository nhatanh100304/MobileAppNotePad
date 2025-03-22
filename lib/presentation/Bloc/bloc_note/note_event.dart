import 'package:firebase/domain/entities/note.dart';

abstract class NoteEvent {}

class LoadNotes extends NoteEvent {
  final String userId;
  LoadNotes(this.userId);
}

class AddNote extends NoteEvent {
  final Note note;
  AddNote(this.note);
}

class UpdateNote extends NoteEvent {
  final Note note;
  UpdateNote(this.note);
}

class DeleteNote extends NoteEvent {
  final String noteId;
  DeleteNote(this.noteId);
}