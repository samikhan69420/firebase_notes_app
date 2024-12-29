// ignore_for_file: must_be_immutable
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:firebase_notes_app/components/notes_closed.dart';
import 'package:firebase_notes_app/models/notes_model.dart';
import 'package:firebase_notes_app/screens/notes_edit.dart';

class NotesWidget extends StatelessWidget {
  final String title;
  final String desc;
  final VoidCallback? onLongTap;
  NoteModel notes;

  NotesWidget({
    super.key,
    this.title = "Title",
    this.desc = "Description",
    this.onLongTap,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openColor: Colors.transparent,
      closedColor: Colors.transparent,
      closedElevation: 0,
      openElevation: 0,
      transitionDuration: const Duration(milliseconds: 500),
      closedBuilder: (context, action) => NotesClosed(title: title, desc: desc),
      openBuilder: (context, action) => NotesEdit(noteModel: notes),
    );
  }
}
