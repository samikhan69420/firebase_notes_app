import 'dart:ui';
import 'package:firebase_notes_app/cubit/crud_cubit_cubit.dart';
import 'package:firebase_notes_app/models/notes_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_notes_app/components/filled_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

showDialogBox(
  BuildContext context, {
  String? text,
  VoidCallback? onTapYes,
  List<NoteModel>? notes,
  String? id,
  int? index,
  double? height,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(45, 255, 255, 255),
              border: Border.all(color: Colors.white),
            ),
            height: height,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      text!,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      filled: false,
                      text: "No",
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Button(
                      onPressed: () {
                        BlocProvider.of<CrudCubitCubit>(context)
                            .deleteData(id!);
                        Navigator.pop(context);
                      },
                      filled: true,
                      text: "Yes",
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      );
    },
  );
}
