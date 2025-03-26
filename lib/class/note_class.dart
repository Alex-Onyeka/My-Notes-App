import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynotes/class/note_item.dart';

class NoteClass {
  final String title;
  final String note;
  final User user;
  final List<NoteItem> noteM;

  NoteClass({
    required this.title,
    required this.note,
    required this.user,
    required this.noteM,
  });
}
