import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/authentication/login_page.dart';
import 'package:mynotes/components/floating_action_button.dart';
import 'package:mynotes/components/my_drawer.dart';
import 'package:mynotes/components/note_list_tile_general.dart';
import 'package:mynotes/components/profile_avatar.dart';
import 'package:mynotes/components/sorting_alert_box.dart';
import 'package:mynotes/pages/home.dart';
import 'package:mynotes/pages/notes_details.dart';
import 'package:mynotes/provider/main_provider.dart';
import 'package:mynotes/services/fire_store_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  Stream<List<String>> _userFavsStream() {
    return FireStoreService().getCurrentUserDocStream().map(
      (userDoc) =>
          List<String>.from(userDoc?.data()?['favs'] ?? []),
    );
  }

  Stream<List<DocumentSnapshot>> _favoriteNotesStream(
    List<String> noteIds,
  ) {
    if (noteIds.isEmpty) {
      return Stream.value([]);
    } // Avoid querying empty list

    return FirebaseFirestore.instance
        .collection('notes')
        .where(FieldPath.documentId, whereIn: noteIds)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  //
  bool isLoading = false;

  void sortNote() {
    showDialog(
      context: context,
      builder: (context) {
        return SortingAlertBox();
      },
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return LoginPage();
            } else {
              return Scaffold(
                drawer: MyDrawer(),
                appBar: AppBar(
                  toolbarHeight:
                      Theme.of(
                        context,
                      ).appBarTheme.toolbarHeight,
                  leadingWidth: 80,
                  centerTitle: true,
                  title: Text(
                    style: TextStyle(
                      color:
                          Theme.of(
                            context,
                          ).colorScheme.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    'General Notes',
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 30.0,
                      ),
                      child: ProfileAvatar(
                        isProfile: false,
                      ),
                    ),
                  ],
                ),
                floatingActionButton: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 15,
                  children: [
                    MyFloatingActionButton(
                      isEdit: false,
                      isEditOn: false,
                      icon: Icons.home,
                      text: 'Go Home',
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                          (route) {
                            return false;
                          },
                        );
                      },
                    ),
                  ],
                ),

                //
                body: Center(
                  child: StreamBuilder<List<String>>(
                    stream: _userFavsStream(),
                    builder: (context, favSnapshot) {
                      if (!favSnapshot.hasData) {
                        return CircularProgressIndicator(
                          color:
                              Theme.of(
                                context,
                              ).colorScheme.tertiary,
                        );
                      }

                      List<String> favs = favSnapshot.data!;

                      if (favs.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 100.0,
                            ),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              spacing: 15,
                              children: [
                                Icon(
                                  size: 30,
                                  color:
                                      Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                  Icons.heart_broken,
                                ),
                                Text(
                                  'You don\'t have any Favorite',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                    fontSize: 22,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return StreamBuilder<
                        List<DocumentSnapshot>
                      >(
                        stream: _favoriteNotesStream(favs),
                        builder: (context, noteSnapshot) {
                          if (!noteSnapshot.hasData) {
                            return Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(
                                      bottom: 100.0,
                                    ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                  spacing: 15,
                                  children: [
                                    Icon(
                                      size: 30,
                                      color:
                                          Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                      Icons
                                          .hourglass_empty_rounded,
                                    ),
                                    Text(
                                      'Loading Favorites...',
                                      style: TextStyle(
                                        color:
                                            Theme.of(
                                                  context,
                                                )
                                                .colorScheme
                                                .secondary,
                                        fontSize: 22,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          List<DocumentSnapshot>
                          favoriteNotes =
                              noteSnapshot.data!;

                          if (favoriteNotes.isEmpty) {
                            return Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(
                                      bottom: 130.0,
                                    ),
                                child: Column(
                                  spacing: 15,
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                  children: [
                                    Icon(
                                      size: 70,
                                      color:
                                          Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                      Icons.heart_broken,
                                    ),
                                    Text(
                                      'No Favorites Found',
                                      style: TextStyle(
                                        color:
                                            Theme.of(
                                                  context,
                                                )
                                                .colorScheme
                                                .secondary,
                                        fontSize: 22,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          List<DocumentSnapshot> notes =
                              noteSnapshot
                                  .data!; // Use noteSnapshot instead of favSnapshot

                          notes.sort((a, b) {
                            Map<String, dynamic> aData =
                                a.data()
                                    as Map<String, dynamic>;
                            Map<String, dynamic> bData =
                                b.data()
                                    as Map<String, dynamic>;

                            if (aData.containsKey(
                                  context
                                      .watch<MainProvider>()
                                      .selectedSort,
                                ) &&
                                bData.containsKey(
                                  context
                                      .watch<MainProvider>()
                                      .selectedSort,
                                )) {
                              if (context
                                      .watch<MainProvider>()
                                      .selectedSort ==
                                  'createdTime') {
                                return bData[context
                                        .watch<
                                          MainProvider
                                        >()
                                        .selectedSort]
                                    .compareTo(
                                      aData[context
                                          .watch<
                                            MainProvider
                                          >()
                                          .selectedSort],
                                    );
                              } else {
                                return aData[context
                                        .watch<
                                          MainProvider
                                        >()
                                        .selectedSort]
                                    .compareTo(
                                      bData[context
                                          .watch<
                                            MainProvider
                                          >()
                                          .selectedSort],
                                    );
                              }
                            } else {
                              return 0;
                            }
                          });

                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(
                                      right: 20.0,
                                    ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.end,

                                  children: [
                                    InkWell(
                                      onTap: () {
                                        sortNote();
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(
                                              right: 10.0,
                                              top: 5,
                                              bottom: 5,
                                              left: 10,
                                            ),
                                        child: Row(
                                          spacing: 6,
                                          children: [
                                            Text(
                                              'Sort Notes',
                                            ),
                                            Icon(
                                              Icons
                                                  .menu_open_rounded,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    bottom: 50,
                                  ),
                                  itemCount:
                                      favoriteNotes.length,
                                  itemBuilder: (
                                    context,
                                    index,
                                  ) {
                                    var noteData =
                                        favoriteNotes[index]
                                                .data()
                                            as Map<
                                              String,
                                              dynamic
                                            >;

                                    String title =
                                        noteData['title'];
                                    String author =
                                        noteData['author'];
                                    String noteId =
                                        noteData['noteId'];
                                    List noteM =
                                        noteData['noteM'];
                                    String text =
                                        noteM[0]['text'];

                                    return NoteListTileGeneral(
                                      noteId: noteId,
                                      onTap: () {
                                        // fireStoreService.noteDb
                                        //     .doc(note.id)
                                        //     .delete();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (
                                              context,
                                            ) {
                                              return NotesDetails(
                                                noteId:
                                                    noteData['noteId'],
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      note: text,
                                      title: title,
                                      author: author,
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
