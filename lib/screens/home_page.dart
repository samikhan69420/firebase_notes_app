import 'package:animations/animations.dart';
import 'package:firebase_notes_app/cubit/crud_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_notes_app/components/app_bar_button.dart';
import 'package:firebase_notes_app/components/blurred_circle.dart';
import 'package:firebase_notes_app/components/dialog.dart';
import 'package:firebase_notes_app/components/notes_closed.dart';
import 'package:firebase_notes_app/components/notes_open.dart';
import 'package:firebase_notes_app/screens/notes_edit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Material(
        child: Stack(
          children: [
            Scaffold(
              floatingActionButton: OpenContainer(
                transitionDuration: const Duration(milliseconds: 500),
                closedBuilder: (context, action) => Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: const Color.fromARGB(45, 255, 255, 255),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                closedColor: Colors.transparent,
                closedElevation: 0,
                openElevation: 0,
                openBuilder: (context, action) => const NotesOpen(),
              ),
              backgroundColor: Colors.black,
              body: Stack(
                children: [
                  BlurredCircle(
                    dx: 20,
                    dy: 50,
                    radius: 100,
                    color: const Color.fromARGB(255, 223, 64, 251),
                    blur: 150,
                  ),
                  BlurredCircle(
                    dx: 290,
                    dy: 200,
                    radius: 70,
                    color: Colors.redAccent,
                    blur: 150,
                  ),
                  BlurredCircle(
                    dx: 20,
                    dy: 600,
                    radius: 100,
                    color: Colors.blue,
                    blur: 150,
                  ),
                  BlurredCircle(
                    dx: 200,
                    dy: 560,
                    radius: 70,
                    color: Colors.greenAccent,
                    blur: 150,
                  ),
                  ListView(
                    children: [
                      const SizedBox(
                        height: 75,
                      ),
                      BlocBuilder<CrudCubitCubit, CrudCubitState>(
                        builder: (context, state) {
                          if (state is CrudCubitLoading) {
                            return SizedBox(
                              height: 954,
                              child: Center(
                                child: SpinKitHourGlass(
                                  duration: 1500.ms,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          } else if (state is CrudCubitError) {
                            return const SizedBox(
                              height: 600,
                              child: Center(
                                child: Text("Something went wrong :<"),
                              ),
                            );
                          } else if (state is CrudCubitLoaded) {
                            final notes = state.notes;
                            return notes.isEmpty
                                ? const Center(
                                    child: Text(
                                      "Tap the + buttons to create\nsome notes",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                : Column(
                                    children: notes.map(
                                      (note) {
                                        return GestureDetector(
                                          onLongPress: () {
                                            showDialogBox(context,
                                                id: note.id,
                                                notes: notes,
                                                height: 250,
                                                text:
                                                    "Are you sure you want to delete this note?");
                                          },
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => NotesEdit(
                                                  noteModel: note,
                                                ),
                                              ),
                                            );
                                          },
                                          child: NotesClosed(
                                            title: note.title,
                                            desc: note.desc,
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  );
                          }
                          return Center(
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: SpinKitHourGlass(
                                duration: 1500.ms,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                SizedBox(
                  height: 100,
                  child: AppBar(
                    title: const Text(
                      "My Notes",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    backgroundColor: const Color.fromARGB(102, 0, 0, 0),
                    actions: const [
                      Row(
                        children: [
                          AppBarButton(
                            icon: Icons.search,
                          ),
                          SizedBox(
                            width: 30,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
