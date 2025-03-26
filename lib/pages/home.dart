import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mynotes/authentication/login_page.dart';
import 'package:mynotes/class/note_class.dart';
import 'package:mynotes/class/note_item.dart';
import 'package:mynotes/components/alert_info.dart';
import 'package:mynotes/components/floating_action_button.dart';
import 'package:mynotes/components/note_list_tile.dart';
import 'package:mynotes/components/my_alert_box.dart';
import 'package:mynotes/components/my_drawer.dart';
import 'package:mynotes/components/profile_avatar.dart';
import 'package:mynotes/components/sorting_alert_box.dart';
import 'package:mynotes/pages/notes_details.dart';
import 'package:mynotes/provider/main_provider.dart';
import 'package:mynotes/services/auth_services.dart';
import 'package:mynotes/services/fire_store_service.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //
  //
  //
  TextEditingController titleController =
      TextEditingController();
  TextEditingController noteController =
      TextEditingController();

  //

  //
  //
  //
  //
  void addNewNote() async {
    showDialog(
      context: context,
      builder:
          (context) => MyAlertBox(
            noteController: noteController,
            titleController: titleController,
            onPressed: () {
              if (titleController.text.isEmpty ||
                  noteController.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertInfo(
                      message:
                          'You Must fill in the title and Notes Fields before creating new Note.',
                      title: 'Empty Fields',
                    );
                  },
                );
              } else {
                fireStoreService.createNote(
                  NoteClass(
                    noteM: [
                      NoteItem(
                        time: Timestamp.now(),
                        text: noteController.text,
                        type: 'Paragraph',
                      ),
                    ],
                    title: titleController.text,
                    note: noteController.text,
                    user:
                        authServices.currentLoggedInUser(),
                  ),
                );
                Navigator.of(context).pop();
                if (!context.mounted) {
                  return;
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Note Added Successfully!',
                      ),
                    ),
                  );
                }
                titleController.clear();
                noteController.clear();
              }
            },
          ),
    ).then((value) {
      titleController.clear();
      noteController.clear();
    });
  }

  //
  //
  //
  //
  bool isLoading = false;
  AuthServices authServices = AuthServices();
  FireStoreService fireStoreService = FireStoreService();
  User? currentUser = FirebaseAuth.instance.currentUser;
  Future<String> getCurrentUserDoc() async {
    QuerySnapshot<Map<String, dynamic>> currentUserDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .where(
              'uid',
              isEqualTo:
                  FirebaseAuth.instance.currentUser!.uid,
            )
            .get();
    var userDoc = currentUserDoc.docs[0].data() as Map;

    String name = userDoc['name'];
    return name;
  }

  //
  //
  //
  void sortNote() {
    showDialog(
      context: context,
      builder: (context) {
        return SortingAlertBox();
      },
    );
  }

  //
  //

  //
  //

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    noteController.dispose();
  }

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
                    'Home Page',
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
                      icon: Icons.add,
                      text: 'Create Note',
                      onTap: () {
                        addNewNote();
                      },
                    ),
                  ],
                ),

                //
                body: StreamBuilder(
                  stream: fireStoreService.getUsersNotes(
                    FirebaseAuth.instance.currentUser!.uid,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 50.0,
                          ),
                          child: Text(
                            'Error',
                            style: TextStyle(
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }

                    if (!snapshot.hasData) {
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
                                    Theme.of(
                                      context,
                                    ).colorScheme.tertiary,
                                Icons
                                    .hourglass_empty_rounded,
                              ),
                              Text(
                                'Loading...',
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

                    var notes = snapshot.data!;

                    if (notes.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 130.0,
                          ),
                          child: Column(
                            spacing: 15,
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Icon(
                                size: 70,
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.tertiary,
                                Icons
                                    .document_scanner_outlined,
                              ),
                              Text(
                                'No Notes Found',
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
                    {
                      List notes = snapshot.data!;
                      notes.sort((a, b) {
                        if (a.data().containsKey(
                              context
                                  .watch<MainProvider>()
                                  .selectedSort,
                            ) &&
                            b.data().containsKey(
                              context
                                  .watch<MainProvider>()
                                  .selectedSort,
                            )) {
                          if (context
                                  .watch<MainProvider>()
                                  .selectedSort ==
                              'createdTime') {
                            return b[context
                                    .watch<MainProvider>()
                                    .selectedSort]
                                .compareTo(
                                  a[context
                                      .watch<MainProvider>()
                                      .selectedSort],
                                );
                          } else {
                            return a[context
                                    .watch<MainProvider>()
                                    .selectedSort]
                                .compareTo(
                                  b[context
                                      .watch<MainProvider>()
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
                            padding: const EdgeInsets.only(
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
                                        Text('Sort Notes'),
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
                              itemCount: notes.length,
                              itemBuilder: (
                                context,
                                index,
                              ) {
                                var note = notes[index];

                                Map<String, dynamic>
                                mapNote =
                                    note.data()
                                        as Map<
                                          String,
                                          dynamic
                                        >;

                                String title =
                                    mapNote['title'];

                                DateTime dateTime =
                                    mapNote['createdTime']
                                        .toDate();
                                String createdTime =
                                    DateFormat(
                                      'MMM - d - y',
                                    ).format(dateTime);

                                return NoteListTile(
                                  onTap: () {
                                    // fireStoreService.noteDb
                                    //     .doc(note.id)
                                    //     .delete();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return NotesDetails(
                                            noteId:
                                                mapNote['noteId'],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  title: title,
                                  createdTime: createdTime,
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              );
            }
          },
        ),

        Visibility(
          visible: isLoading,
          child: Container(
            color: const Color.fromARGB(100, 0, 0, 0),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
