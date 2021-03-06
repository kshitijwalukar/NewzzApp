import 'package:flutter/material.dart';

final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, isImportant, number, title, description, country, language, arrange, timeranges, time
  ];

  static final String id = '_id';
  static final String isImportant = 'isImportant';
  static final String number = 'number';
  static final String title = 'title';
  static final String description = 'description';
  static final String country = 'country';
  static final String language = 'language';
  static final String arrange = 'arrange';
  static final String timeranges = 'timeranges';
  static final String time = 'time';
}

class Note {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final String country;
  final String language;
  final String arrange;
  final String timeranges;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.country,
    required this.language,
    required this.arrange,
    required this.timeranges,
    required this.createdTime,
  });

  Note copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    String? country,
    String? language,
    String? arrange,
    String? timeranges,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        country: country ?? this.country,
        language: language ?? this.language,
        arrange: arrange ?? this.arrange,
        timeranges: timeranges ?? this.timeranges,
        createdTime: createdTime ?? this.createdTime,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        isImportant: json[NoteFields.isImportant] == 1,
        number: json[NoteFields.number] as int,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        country: json[NoteFields.country] as String,
        language: json[NoteFields.language] as String,
        arrange: json[NoteFields.arrange] as String,
        timeranges: json[NoteFields.timeranges] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title.toUpperCase(),
        NoteFields.isImportant: isImportant ? 1 : 0,
        NoteFields.number: number,
        NoteFields.description: description,
        NoteFields.country: country,
        NoteFields.language: language,
        NoteFields.arrange: arrange,
        NoteFields.timeranges: timeranges,
        NoteFields.time: createdTime.toIso8601String(),
      };
}
