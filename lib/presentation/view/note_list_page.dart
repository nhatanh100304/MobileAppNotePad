import 'package:firebase/domain/entities/note.dart';
import 'package:firebase/presentation/Bloc/bloc_note/note_bloc.dart';
import 'package:firebase/presentation/Bloc/bloc_note/note_event.dart';
import 'package:firebase/presentation/Bloc/bloc_note/note_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'note_edit_page.dart';

class NotepadListPage extends StatelessWidget {
  final String userId;

  NotepadListPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notepad")),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NoteLoaded) {
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(note.content),
                        Text(
                          "Ngày tạo: ${DateFormat('dd/MM/yyyy HH:mm').format(note.createdAt)}",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _confirmDelete(context, note.id);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoteEditorPage(note: note),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
          return Center(child: Text("Không có ghi chú nào!"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newNote = Note(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            userId: userId,
            title: "Ghi chú mới",
            content: "",
            createdAt: DateTime.now(),
          );
          context.read<NoteBloc>().add(AddNote(newNote));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _confirmDelete(BuildContext context, String noteId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Xác nhận xóa"),
          content: Text("Bạn có chắc chắn muốn xóa ghi chú này không?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text("Hủy"),
            ),
            TextButton(
              onPressed: () {
                context.read<NoteBloc>().add(DeleteNote(noteId));
                Navigator.pop(dialogContext);
              },
              child: Text("Xóa", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
