import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newzzapp/db/notes_database.dart';
import 'package:newzzapp/model/note.dart';
import 'package:newzzapp/widget/note_form_widget.dart';

class AddEditNotePage extends StatefulWidget {
  final Note? note;

  const AddEditNotePage({
    Key? key,
    this.note,
  }) : super(key: key);
  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;
  late String country;
  late String language;
  late String arrange;
  late String timeranges;

  @override
  void initState() {
    super.initState();
    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
    country = widget.note?.country ?? '';
    language = widget.note?.language ?? '';
    arrange = widget.note?.arrange ?? '';
    timeranges = widget.note?.timeranges ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("NEWZZAPP"),
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidget(
            isImportant: isImportant,
            number: number,
            title: title,
            description: description,
            country: country,
            language: language,
            arrange: arrange,
            timeranges: timeranges,
            onChangedImportant: (isImportant) =>
                setState(() => this.isImportant = isImportant),
            onChangedNumber: (number) => setState(() => this.number = number),
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
            onChangedCountry: (country) =>
                setState(() => this.country = country),
            onChangedLanguage: (language) =>
                setState(() => this.language = language),
            onChangedArrange: (arrange) =>
                setState(() => this.arrange = arrange),
            onChangedtimeranges: (timeranges) =>
                setState(() => this.timeranges = timeranges),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.green,
          primary: isFormValid ? Colors.white : Colors.white54,
        ),
        onPressed: addOrUpdateNote,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
      country: country,
      language: language,
      arrange: arrange,
      timeranges: timeranges,
    );

    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      title: title,
      isImportant: true,
      number: number,
      description: description,
      country: country,
      language: language,
      arrange: arrange,
      timeranges: timeranges,
      createdTime: DateTime.now(),
    );

    await NotesDatabase.instance.create(note);
  }
}
