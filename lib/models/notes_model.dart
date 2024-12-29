import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String? id;
  final String? title;
  final String? desc;

  NoteModel({
    this.id,
    this.title,
    this.desc,
  });
  factory NoteModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return NoteModel(
      id: snapshot['id'],
      title: snapshot['title'],
      desc: snapshot['desc'],
    );
  }

  Map<String, dynamic> toDocument() => {
        "title": title,
        "desc": desc,
        "id": id,
      };
}