import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_notes_app/cubit/crud_cubit_cubit.dart';
import 'package:firebase_notes_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_notes_app/screens/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    BlocProvider<CrudCubitCubit>(
      create: (BuildContext context) => CrudCubitCubit()..readData(),
      child: const HomePage(),
    ),
  );
}
