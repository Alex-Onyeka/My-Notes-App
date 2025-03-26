import 'package:cloud_firestore/cloud_firestore.dart';

class NoteItem {
  final String text;
  final String type;
  final Timestamp time;
  NoteItem({
    required this.text,
    required this.type,
    required this.time,
  });
}
