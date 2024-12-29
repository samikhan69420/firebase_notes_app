import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_notes_app/models/database_handler.dart';
import 'package:firebase_notes_app/models/notes_model.dart';

part 'crud_cubit_state.dart';

class CrudCubitCubit extends Cubit<CrudCubitState> {
  CrudCubitCubit() : super(CrudCubitInitial());

  void readData() {
    emit(CrudCubitLoading());
    final streamResponse = DatabaseHandler.getNotes();
    streamResponse.listen(
      (notesList) {
        emit(CrudCubitLoaded(notesList));
      },
    );
  }

  void createData(NoteModel note) {
    if (state is CrudCubitLoaded) {
      DatabaseHandler.createNote(note);
    }
  }

  void updateData(NoteModel note) {
    if (state is CrudCubitLoaded) {
      DatabaseHandler.updateNotes(note);
    }
  }

  void deleteData(String id) {
    if (state is CrudCubitLoaded) {
      DatabaseHandler.deleteNote(id);
    }
  }
}
