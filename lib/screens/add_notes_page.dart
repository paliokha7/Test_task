import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_test_task/cubit/note_cubit.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Note',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
        ),
        elevation: 5,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              //Title
              TextFormField(
                controller: titleController,
                style: const TextStyle(
                  fontSize: 28,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                ),
              ),
              const SizedBox(height: 6),
              //Description
              TextFormField(
                controller: descriptionController,
                maxLines: null,
                style: const TextStyle(
                  fontSize: 24,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Description',
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<NoteCubit>().addNote(
                titleController.text.trim(),
                descriptionController.text.trim(),
                context,
              );
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
