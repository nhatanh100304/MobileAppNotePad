import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/domain/entities/note.dart';
import 'package:firebase/domain/repositories/note_repository.dart';

class NoteRepositoryImplementation implements NoteRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> createNote(Note note) async {
    await firestore.collection("notes").doc(note.id).set({
      'userId': note.userId,
      'title': note.title,
      'content': note.content,
      'createdAt': note.createdAt.toIso8601String(),
    });
  }

  @override
  Future<List<Note>> getNotes(String userId) async {
    final snapshot = await firestore
        .collection("notes")
        .where("userId", isEqualTo: userId)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Note(
        id: doc.id,
        userId: data['userId'],
        title: data['title'],
        content: data['content'],
        createdAt: DateTime.parse(data['createdAt']),
      );
    }).toList();
  }

  @override
  Future<void> updateNote(Note note) async {
    await firestore.collection("notes").doc(note.id).update({
      'title': note.title,
      'content': note.content,
    });
  }

  @override
  Future<void> deleteNote(String noteId) async {
    await firestore.collection("notes").doc(noteId).delete();
  }
}