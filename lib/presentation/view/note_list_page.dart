import 'package:firebase/domain/entities/note.dart';
import 'package:firebase/presentation/Bloc/bloc_note/note_bloc.dart';
import 'package:firebase/presentation/Bloc/bloc_note/note_event.dart';
import 'package:firebase/presentation/Bloc/bloc_note/note_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteEditorPage(note: note),
                      ),
                    );
                  },
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
}