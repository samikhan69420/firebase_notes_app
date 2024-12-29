// ignore_for_file: must_be_immutable
import 'package:firebase_notes_app/cubit/crud_cubit_cubit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_notes_app/components/app_bar_button.dart';
import 'package:firebase_notes_app/components/field.dart';
import 'package:firebase_notes_app/models/notes_model.dart';

class NotesEdit extends StatefulWidget {
  final NoteModel noteModel;
  String? id;
  NotesEdit({
    super.key,
    required this.noteModel,
    this.id,
  });

  @override
  State<NotesEdit> createState() => _NotesOpenState();
}

class _NotesOpenState extends State<NotesEdit> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  bool _isNoteUpdating = false;

  FocusNode titleNode = FocusNode();
  FocusNode descNode = FocusNode();

  _updateNote() {
    setState(() => _isNoteUpdating = true);
    if (_titleController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter Title');
      setState(() => _isNoteUpdating = false);
      return;
    }
    if (_descController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Type something in the body');
      setState(() => _isNoteUpdating = false);
      return;
    }
    BlocProvider.of<CrudCubitCubit>(context).updateData(NoteModel(
      title: _titleController.text,
      desc: _descController.text,
      id: widget.noteModel.id,
    ));
    titleNode.unfocus();
    descNode.unfocus();
    Future.delayed(1000.ms).then(
      (value) => Navigator.pop(context),
    );
  }

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.noteModel.title);
    _descController = TextEditingController(text: widget.noteModel.desc);
    super.initState();
  }

  @override
  void dispose() {
    titleNode.dispose();
    descNode.dispose();
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBarButton(
                        onTap: () => Navigator.pop(context),
                        icon: Icons.arrow_back_ios_new_outlined,
                      ),
                      const Spacer(),
                      const AppBarButton(
                        icon: Icons.search,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      AppBarButton(
                          icon: Icons.save_outlined,
                          onTap: () => _updateNote()),
                    ],
                  ),
                ),
              )
            ],
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.black,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  MyFormField(
                    onTapNext: (p0) {
                      descNode.requestFocus();
                    },
                    focusNode: titleNode,
                    controller: _titleController,
                    fontSize: 40,
                    maxLines: 1,
                    text: 'Title',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    child: Divider(
                      color: Colors.grey[800],
                    ),
                  ),
                  MyFormField(
                    onTapNext: (p0) {},
                    focusNode: descNode,
                    text: 'Description',
                    fontSize: 20,
                    controller: _descController,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: AbsorbPointer(
            absorbing: _isNoteUpdating,
          ),
        ),
        _isNoteUpdating
            ? Container(
                color: const Color.fromARGB(50, 0, 0, 0),
                height: double.infinity,
                width: double.infinity,
                child: const SpinKitSpinningLines(
                  color: Colors.white,
                ),
              )
            : Container(),
      ],
    );
  }
}
