import 'package:firebase/domain/entities/note.dart';

abstract class NoteRepository {
  Future<void> createNote(Note note);
  Future<List<Note>> getNotes(String userId);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(String noteId);
}
