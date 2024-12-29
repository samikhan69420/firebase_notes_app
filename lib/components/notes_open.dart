import 'package:firebase_notes_app/cubit/crud_cubit_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_notes_app/components/app_bar_button.dart';
import 'package:firebase_notes_app/components/field.dart';
import 'package:firebase_notes_app/models/notes_model.dart';

// ignore: must_be_immutable
class NotesOpen extends StatefulWidget {
  const NotesOpen({
    super.key,
  });

  @override
  State<NotesOpen> createState() => _NotesOpenState();
}

class _NotesOpenState extends State<NotesOpen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  FocusNode titleFocusNode = FocusNode();
  FocusNode descFocusNode = FocusNode();

  bool _isNoteCreating = false;

  Future createNoteCubit() async {
    BlocProvider.of<CrudCubitCubit>(context).createData(
      NoteModel(
        title: _titleController.text,
        desc: _descController.text,
      ),
    );
  }

  _createNote() {
    titleFocusNode.unfocus();
    descFocusNode.unfocus();
    setState(() => _isNoteCreating = true);
    Future.delayed(const Duration(milliseconds: 1000)).then(
      (value) {
        if (_titleController.text.isEmpty) {
          Fluttertoast.showToast(msg: 'Enter Title');
          setState(() => _isNoteCreating = false);
          return;
        }
        if (_descController.text.isEmpty) {
          Fluttertoast.showToast(msg: 'Type something in the body');
          setState(() => _isNoteCreating = false);
          return;
        }
        createNoteCubit().then(
          (value) {
            _isNoteCreating = false;
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    titleFocusNode.dispose();
    descFocusNode.dispose();
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
                        icon: Icons.check,
                        onTap: () => _createNote(),
                      ),
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
                      descFocusNode.requestFocus();
                    },
                    focusNode: titleFocusNode,
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
                    focusNode: descFocusNode,
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
            absorbing: _isNoteCreating,
          ),
        ),
        _isNoteCreating
            ? Container(
                color: const Color.fromARGB(100, 0, 0, 0),
                width: double.infinity,
                height: double.infinity,
                child: const SpinKitSpinningLines(
                  color: Colors.white,
                ),
              )
            : Container(),
      ],
    );
  }
}
