import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/services/fire_store_service.dart';

class NoteListTileGeneral extends StatefulWidget {
  final String title;
  final String note;
  final String author;
  final Function()? onTap;
  final String noteId;
  const NoteListTileGeneral({
    super.key,
    required this.title,
    required this.note,
    required this.author,
    required this.onTap,
    required this.noteId,
  });

  @override
  State<NoteListTileGeneral> createState() =>
      _NoteListTileGeneralState();
}

class _NoteListTileGeneralState
    extends State<NoteListTileGeneral> {
  //
  //
  String cutTextTitle(String text) {
    if (text.length > 20) {
      return '${text.substring(0, 20)}...'.toUpperCase();
    } else {
      return text.toUpperCase();
    }
  }

  String cutTextNote(String text) {
    if (text.length > 80) {
      return '${text.substring(0, 80)}...';
    } else {
      return text;
    }
  }

  void addToUserFavs(String noteId) {
    FireStoreService().userDb
        .doc(
          FireStoreService().authServices
              .currentLoggedInUser()
              .uid,
        )
        .update({
          'favs': FieldValue.arrayUnion([noteId]),
        });
  }

  void removeFromUserFavs(String noteId) {
    FireStoreService().userDb
        .doc(
          FireStoreService().authServices
              .currentLoggedInUser()
              .uid,
        )
        .update({
          'favs': FieldValue.arrayRemove([noteId]),
        });
  }

  //
  //
  //
  List<String> userFavs = []; // Store user favs

  @override
  void initState() {
    super.initState();
    _getUserFavs();
  }

  void _getUserFavs() {
    FireStoreService().getCurrentUserDocStream().listen((
      userDoc,
    ) {
      if (userDoc != null && userDoc.exists) {
        var data = userDoc.data(); // Safe casting
        if (data != null && data.containsKey('favs')) {
          setState(() {
            userFavs = List<String>.from(
              data['favs'],
            ); // Extract favs list
          });
        }
      }
    });
  }

  //
  //
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 30,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color:
                  Theme.of(
                    context,
                  ).colorScheme.surfaceContainer,
            ),
            child: ListTile(
              trailing: Icon(
                size: 20,
                color:
                    Theme.of(context).colorScheme.tertiary,
                Icons.arrow_forward_ios_rounded,
              ),
              contentPadding: EdgeInsets.fromLTRB(
                25,
                5,
                20,
                5,
              ),
              title: Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 5,
                ),
                child: Text(
                  style: TextStyle(
                    color:
                        Theme.of(
                          context,
                        ).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  cutTextTitle(widget.title),
                ),
              ),

              subtitle: Padding(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  spacing: 15,
                  children: [
                    Text(
                      style: TextStyle(
                        color:
                            Theme.of(
                              context,
                            ).colorScheme.secondary,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      cutTextNote(widget.note),
                    ),
                    Text(
                      style: TextStyle(
                        color:
                            Theme.of(
                              context,
                            ).colorScheme.secondary,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                      'Author: ${widget.author}',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 40.0,
                top: 10,
              ),
              child:
                  userFavs.contains(widget.noteId)
                      ? IconButton(
                        onPressed: () {
                          removeFromUserFavs(widget.noteId);
                        },
                        icon: Icon(
                          color:
                              Theme.of(
                                context,
                              ).colorScheme.secondary,
                          Icons.favorite,
                        ),
                      )
                      : IconButton(
                        onPressed: () {
                          addToUserFavs(widget.noteId);
                        },
                        icon: Icon(
                          color:
                              Theme.of(
                                context,
                              ).colorScheme.secondary,
                          Icons.favorite_border_rounded,
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
