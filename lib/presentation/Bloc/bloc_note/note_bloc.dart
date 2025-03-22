import 'package:firebase/domain/repositories/note_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository noteRepository;

  NoteBloc(this.noteRepository) : super(NoteInitial()) {
    on<LoadNotes>((event, emit) async {
      emit(NoteLoading());
      try {
        final notes = await noteRepository.getNotes(event.userId);
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(NoteError("Lỗi khi tải ghi chú."));
      }
    });

    on<AddNote>((event, emit) async {
      try {
        await noteRepository.createNote(event.note);
        add(LoadNotes(event.note.userId)); // Load lại danh sách
      } catch (e) {
        emit(NoteError("Lỗi khi thêm ghi chú."));
      }
    });

    on<UpdateNote>((event, emit) async {
      try {
        await noteRepository.updateNote(event.note);
        add(LoadNotes(event.note.userId));
      } catch (e) {
        emit(NoteError("Lỗi khi cập nhật ghi chú."));
      }
    });

    on<DeleteNote>((event, emit) async {
      try {
        await noteRepository.deleteNote(event.noteId);
        add(LoadNotes(event.noteId));
      } catch (e) {
        emit(NoteError("Lỗi khi xóa ghi chú."));
      }
    });
  }
}