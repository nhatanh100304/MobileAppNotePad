import 'package:firebase/domain/entities/note.dart';
import 'package:firebase/presentation/Bloc/bloc_note/note_bloc.dart';
import 'package:firebase/presentation/Bloc/bloc_note/note_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteEditorPage extends StatelessWidget {
  final Note note;

  NoteEditorPage({required this.note});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _titleController.text = note.title;
    _contentController.text = note.content;

    return Scaffold(
      appBar: AppBar(title: Text("Chỉnh sửa ghi chú")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: InputDecoration(labelText: "Tiêu đề")),
            TextField(controller: _contentController, decoration: InputDecoration(labelText: "Nội dung")),
            ElevatedButton(
              onPressed: () {
                final updatedNote = note.copyWith(title: _titleController.text, content: _contentController.text);
                context.read<NoteBloc>().add(UpdateNote(updatedNote));
                Navigator.pop(context);
              },
              child: Text("Lưu"),
            ),
          ],
        ),
      ),
    );
  }
}