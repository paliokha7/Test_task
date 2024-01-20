import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_app_test_task/cubit/note_cubit.dart';
import 'package:note_app_test_task/firebase_options.dart';
import 'package:note_app_test_task/theme/pallete.dart';
import 'package:note_app_test_task/screens/add_notes_page.dart';
import 'package:note_app_test_task/screens/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteCubit>(
          create: (context) => NoteCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Note App',
        theme: Pallete.darkModeAppTheme,
        initialRoute: '/',
        routes: {
          '/': (_) => const HomePage(),
          '/add-notes': (_) => const AddNotePage(),
        },
      ),
    );
  }
}
