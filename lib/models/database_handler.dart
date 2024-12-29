import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_notes_app/models/notes_model.dart';

class DatabaseHandler {
  static Future<void> createNote(NoteModel note) async {
    final notesCollection = FirebaseFirestore.instance.collection('notes');
    final id = notesCollection.doc().id;
    final newNote = NoteModel(
      id: id,
      title: note.title,
      desc: note.desc,
    ).toDocument();

    notesCollection.doc(id).set(newNote);
  }

  static Stream<List<NoteModel>> getNotes() {
    final notesCollection = FirebaseFirestore.instance.collection('notes');
    return notesCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => NoteModel.fromSnapshot(e)).toList());
  }

  static Future<void> updateNotes(NoteModel note) async {
    final noteCollection = FirebaseFirestore.instance.collection('notes');
    final newNote = NoteModel(
      id: note.id,
      title: note.title,
      desc: note.desc,
    ).toDocument();

    try {
      await noteCollection.doc(note.id).update(newNote);
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> deleteNote(String id) async {
    try {
      FirebaseFirestore.instance.collection('notes').doc(id).delete();
    } catch (e) {
      print("An error occured ${e.toString()}");
    }
  }
}
