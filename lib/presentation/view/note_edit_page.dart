import 'package:firebase/domain/entities/note.dart';
import 'package:firebase/presentation/Bloc/bloc_note/note_bloc.dart';
import 'package:firebase/presentation/Bloc/bloc_note/note_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NoteEditorPage extends StatefulWidget {
  final Note note;

  NoteEditorPage({required this.note});

  @override
  _NoteEditorPageState createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chỉnh sửa ghi chú"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () => _confirmDelete(context, widget.note.id),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(controller: _titleController, decoration: InputDecoration(labelText: "Tiêu đề")),
            TextField(controller: _contentController, decoration: InputDecoration(labelText: "Nội dung")),
            SizedBox(height: 10),
            Text(
              "Ngày tạo: ${DateFormat('dd/MM/yyyy HH:mm').format(widget.note.createdAt)}",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedNote = widget.note.copyWith(
                  title: _titleController.text,
                  content: _contentController.text,
                );
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
                Navigator.pop(context); // Quay về danh sách ghi chú sau khi xóa
              },
              child: Text("Xóa", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
