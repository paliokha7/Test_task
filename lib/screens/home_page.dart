import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_test_task/cubit/note_cubit.dart';
import 'package:note_app_test_task/data/model/note_model.dart';
import 'package:note_app_test_task/theme/pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<NoteCubit>().getNote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
        ),
        elevation: 5,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: BlocBuilder<NoteCubit, List<NoteModel>>(
          builder: (context, notes) {
            return ListView.separated(
              itemCount: notes.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 16.0),
              itemBuilder: (context, index) {
                final note = notes[index];
                //Delete note
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    context.read<NoteCubit>().deleteNote(note.docId!);
                  },
                  background: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.centerRight,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.delete),
                    ),
                  ),
                  //Note list
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFFFF599),
                        borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      title: Text(
                        note.title,
                        style: const TextStyle(
                          color: Pallete.blackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        note.description,
                        style: const TextStyle(
                          color: Pallete.blackColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-notes');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
