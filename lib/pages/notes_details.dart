import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mynotes/components/are_you_sure_alert_box.dart';
import 'package:mynotes/components/details_info_tab.dart';
import 'package:mynotes/components/edit_note_alert_box.dart';
import 'package:mynotes/components/floating_action_button.dart';
import 'package:mynotes/components/template_note.dart';
import 'package:mynotes/components/text_field_message_editnote.dart';
import 'package:mynotes/pages/my_profile.dart';
import 'package:mynotes/provider/theme_provider.dart';
import 'package:mynotes/services/fire_store_service.dart';
import 'package:provider/provider.dart';

class NotesDetails extends StatefulWidget {
  final String noteId;
  const NotesDetails({super.key, required this.noteId});

  @override
  State<NotesDetails> createState() => _NotesDetailsState();
}

class _NotesDetailsState extends State<NotesDetails> {
  //
  //
  //
  String selectedType = 'Paragraph';
  List types = ['Title', 'Sub-Title', 'Paragraph'];
  String selectedValue = 'Paragraph';

  bool isEditOn = false;

  bool hideHeader = false;
  //
  //
  //
  String? convertDate() {
    DateTime dateTime = noteDoc['createdTime'].toDate();
    String createdTime = DateFormat(
      'MMM-d-y',
    ).format(dateTime);
    return createdTime;
  }

  TextEditingController textEditingController =
      TextEditingController();

  void setTextController(String text) {
    textEditingController.text = text;
  }

  void editNoteByAddingNewText(String text) {
    showDialog(
      context: context,
      builder: (context) {
        return EditNoteAlertBox(
          noteController: textEditingController,
          onPressed: () {},
        );
      },
    );
  }

  Map<String, dynamic> noteDoc = {};

  //
  //

  //
  @override
  void initState() {
    super.initState();
    _getNoteDoc();
  }

  void _getNoteDoc() async {
    DocumentSnapshot<Map<String, dynamic>> note =
        await FireStoreService().noteDb
            .doc(widget.noteId)
            .get();

    Map<String, dynamic> data = note.data()!;

    setState(() {
      noteDoc = data;
    });
  }
  //
  //
  //
  //
  //

  @override
  Widget build(BuildContext context) {
    if (noteDoc.isEmpty) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight:
              Theme.of(context).appBarTheme.toolbarHeight,
          leadingWidth: 80,
          centerTitle: true,
          title: Text(
            style: TextStyle(
              color:
                  Theme.of(context).colorScheme.secondary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            isEditOn
                ? '... Note Edit Mode ...'
                : 'Note Details',
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Switch(
                value:
                    context
                        .watch<ThemeProvider>()
                        .isDarkMode,
                onChanged: (newValue) {
                  context
                      .read<ThemeProvider>()
                      .changeTheme();
                },
              ),
            ),
          ],
        ),
        //
        //
        floatingActionButton: Row(
          mainAxisAlignment:
              isEditOn
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.end,
          children: [
            Visibility(
              visible: isEditOn,
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: MyFloatingActionButton(
                  isEdit: false,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: Text(
                              style: TextStyle(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              'Add Text Block',
                            ),
                          ),
                          content: Column(
                            spacing: 15,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              TextFieldMessageEditnote(
                                controller:
                                    textEditingController,
                                hint: 'Enter your note',
                                value:
                                    textEditingController
                                        .text,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                spacing: 10,
                                mainAxisSize:
                                    MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                    children: [
                                      Text(
                                        style: TextStyle(
                                          color:
                                              Theme.of(
                                                    context,
                                                  )
                                                  .colorScheme
                                                  .secondary,
                                          fontWeight:
                                              FontWeight
                                                  .bold,
                                          fontSize: 13,
                                        ),
                                        'Set Block Type',
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                    child: DropdownButton<
                                      String
                                    >(
                                      value: selectedValue,
                                      onChanged: (
                                        newValue,
                                      ) {
                                        {
                                          setState(() {
                                            selectedValue =
                                                newValue!;
                                          });
                                        }
                                      },
                                      items:
                                          [
                                                "Title",
                                                "Sub-title",
                                                "Paragraph",
                                              ]
                                              .map(
                                                (
                                                  String
                                                  item,
                                                ) => DropdownMenuItem<
                                                  String
                                                >(
                                                  value:
                                                      item,
                                                  child:
                                                      Text(
                                                        item,
                                                      ),
                                                ),
                                              )
                                              .toList(),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                mainAxisSize:
                                    MainAxisSize.min,
                                spacing: 10,
                                children: [
                                  MaterialButton(
                                    onPressed: () async {
                                      try {
                                        FireStoreService()
                                            .noteDb
                                            .doc(
                                              noteDoc['noteId'],
                                            )
                                            .update({
                                              'noteM': FieldValue.arrayUnion([
                                                {
                                                  'text':
                                                      textEditingController
                                                          .text,
                                                  'type':
                                                      selectedValue,
                                                  'time':
                                                      Timestamp.now(),
                                                },
                                              ]),
                                            });
                                        _getNoteDoc();

                                        if (!context
                                            .mounted) {
                                          return;
                                        }
                                        Navigator.of(
                                          context,
                                        ).pop();
                                        textEditingController
                                            .clear();
                                        setState(() {
                                          selectedValue =
                                              'Paragraph';
                                        });
                                      } catch (e) {
                                        // print(
                                        //   e,
                                        // );
                                      }
                                    },
                                    child: Text(
                                      style: TextStyle(
                                        color:
                                            Theme.of(
                                                  context,
                                                )
                                                .colorScheme
                                                .primary,
                                      ),
                                      'Save Note',
                                    ),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.of(
                                        context,
                                      ).pop();
                                    },
                                    child: Text(
                                      style: TextStyle(
                                        color:
                                            Theme.of(
                                                  context,
                                                )
                                                .colorScheme
                                                .secondary,
                                      ),
                                      'Cancel',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: Icons.note_add_outlined,
                  text: 'Add New Text',
                  isEditOn: isEditOn,
                ),
              ),
            ),
            Visibility(
              visible:
                  FirebaseAuth.instance.currentUser!.uid ==
                  noteDoc['user'],
              child: MyFloatingActionButton(
                isEditOn: isEditOn,
                isEdit: true,
                icon: Icons.edit_square,
                text: 'Edit Note',
                onTap: () {
                  setState(() {
                    isEditOn = !isEditOn;
                  });
                },
              ),
            ),
          ],
        ),
        //
        //
        body: Padding(
          padding: const EdgeInsets.only(
            left: 30.0,
            right: 30,
            bottom: 0,
          ),
          child: SizedBox(
            // height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Visibility(
                        visible: !hideHeader,
                        child: SizedBox(
                          child: TemplateNote(
                            showDelete: false,
                            type: 'Header',
                            editNote: () {
                              setTextController(
                                noteDoc['title'],
                              );
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.only(
                                            top: 10.0,
                                          ),
                                      child: Text(
                                        style: TextStyle(
                                          color:
                                              Theme.of(
                                                    context,
                                                  )
                                                  .colorScheme
                                                  .primary,
                                          fontSize: 18,
                                          fontWeight:
                                              FontWeight
                                                  .bold,
                                        ),
                                        'Edit Your Title',
                                      ),
                                    ),
                                    content: Column(
                                      spacing: 15,
                                      mainAxisSize:
                                          MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                      children: [
                                        TextFieldMessageEditnote(
                                          controller:
                                              textEditingController,
                                          hint:
                                              'Enter your Title',
                                          value:
                                              textEditingController
                                                  .text,
                                        ),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                          mainAxisSize:
                                              MainAxisSize
                                                  .min,
                                          spacing: 10,
                                          children: [
                                            MaterialButton(
                                              onPressed: () async {
                                                try {
                                                  await FireStoreService()
                                                      .noteDb
                                                      .doc(
                                                        noteDoc['noteId'],
                                                      )
                                                      .update({
                                                        'title':
                                                            textEditingController.text,
                                                      });
                                                  _getNoteDoc();

                                                  if (!context
                                                      .mounted) {
                                                    return;
                                                  }
                                                  Navigator.of(
                                                    context,
                                                  ).pop();
                                                  textEditingController
                                                      .clear();
                                                } catch (
                                                  e
                                                ) {
                                                  // print(
                                                  //   e,
                                                  // );
                                                }
                                              },
                                              child: Text(
                                                style: TextStyle(
                                                  color:
                                                      Theme.of(
                                                        context,
                                                      ).colorScheme.primary,
                                                ),
                                                'Save Title',
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                Navigator.of(
                                                  context,
                                                ).pop();
                                              },
                                              child: Text(
                                                style: TextStyle(
                                                  color:
                                                      Theme.of(
                                                        context,
                                                      ).colorScheme.secondary,
                                                ),
                                                'Cancel',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            text:
                                noteDoc['title']
                                    .toUpperCase(),
                            isEdit: isEditOn,
                            delete: () {},
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !isEditOn && !hideHeader,
                        child: SizedBox(height: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0.0,
                        ),
                        child: Row(
                          spacing: 10,
                          mainAxisAlignment:
                              isEditOn
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment
                                      .center,
                          children: [
                            Visibility(
                              visible:
                                  isEditOn && !hideHeader,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(
                                      top: 10.0,
                                    ),
                                child: SizedBox(
                                  width: 110,
                                  child: DetailsInfoTab(
                                    backGroundcolor:
                                        const Color.fromARGB(
                                          255,
                                          255,
                                          242,
                                          241,
                                        ),
                                    outlineColor:
                                        Colors.red.shade100,
                                    textColor:
                                        Colors.red.shade300,
                                    isButton: false,
                                    text: 'Delete Note',
                                    icon:
                                        Icons
                                            .delete_outline_rounded,
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AreYouSureAlertBox(
                                            title:
                                                'Are You Sure?',
                                            message:
                                                'You Are about to delete your note, are you sure you want to proceed?',
                                            onPressed: () {
                                              FireStoreService()
                                                  .noteDb
                                                  .doc(
                                                    noteDoc['noteId'],
                                                  )
                                                  .delete();
                                              Navigator.of(
                                                  context,
                                                )
                                                ..pop()
                                                ..pop();
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible:
                                  !isEditOn && !hideHeader,
                              child: Expanded(
                                child: DetailsInfoTab(
                                  isButton: true,
                                  text: noteDoc['author'],
                                  icon: Icons.person,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return MyProfile(
                                            userUid:
                                                noteDoc['user'],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Visibility(
                              visible:
                                  !isEditOn && !hideHeader,
                              child: Expanded(
                                child: DetailsInfoTab(
                                  isButton: false,
                                  text:
                                      convertDate() ??
                                      'Date',
                                  icon:
                                      Icons
                                          .date_range_outlined,
                                  onTap: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5.0,
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          spacing: 15,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                              children: [
                                Text(
                                  style: TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                    color:
                                        Theme.of(context)
                                            .colorScheme
                                            .primary,
                                    fontSize: 15,
                                  ),
                                  'Body of Note: ',
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      hideHeader =
                                          !hideHeader;
                                    });
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 2,
                                        ),
                                    child: Row(
                                      spacing: 5,
                                      children: [
                                        Text(
                                          style: TextStyle(
                                            color:
                                                Theme.of(
                                                      context,
                                                    )
                                                    .colorScheme
                                                    .primary,
                                            fontWeight:
                                                FontWeight
                                                    .w500,
                                            fontSize: 13,
                                          ),
                                          hideHeader
                                              ? 'Show Header'
                                              : 'Full Screen',
                                        ),
                                        RotatedBox(
                                          quarterTurns:
                                              hideHeader
                                                  ? 1
                                                  : 3,
                                          child: Icon(
                                            size: 21,
                                            color:
                                                Theme.of(
                                                      context,
                                                    )
                                                    .colorScheme
                                                    .secondary,
                                            Icons
                                                .arrow_back_ios_new_rounded,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  hideHeader
                                      ? MediaQuery.of(
                                            context,
                                          ).size.height *
                                          0.68
                                      : MediaQuery.of(
                                            context,
                                          ).size.height *
                                          0.50,

                              child: ListView.builder(
                                primary: false,
                                itemCount:
                                    noteDoc['noteM'].length,
                                itemBuilder: (
                                  context,
                                  index,
                                ) {
                                  List types =
                                      noteDoc['noteM'];
                                  Map note =
                                      types[index] as Map;
                                  String text =
                                      note['text'];
                                  String type =
                                      note['type'];
                                  // String? noteId = note['noteId'];
                                  return SizedBox(
                                    child: TemplateNote(
                                      showDelete: true,
                                      delete: () {
                                        showDialog(
                                          context: context,
                                          builder: (
                                            context,
                                          ) {
                                            return AreYouSureAlertBox(
                                              title:
                                                  'Are You Sure?',
                                              message:
                                                  'You are about to delete a text block on your Note, are you sure you want to proceed?',
                                              onPressed: () async {
                                                // print(
                                                //   'Updating note ID: ${widget.note['noteId']}',
                                                // );
                                                try {
                                                  // print(
                                                  //   selectedType,
                                                  // );

                                                  DocumentReference
                                                  docRef = FireStoreService()
                                                      .noteDb
                                                      .doc(
                                                        noteDoc['noteId'],
                                                      );

                                                  // Step 1: Fetch the document
                                                  DocumentSnapshot
                                                  snapshot =
                                                      await docRef
                                                          .get();

                                                  if (snapshot
                                                      .exists) {
                                                    List<
                                                      dynamic
                                                    >
                                                    currentNotes = List.from(
                                                      snapshot.get(
                                                        'noteM',
                                                      ),
                                                    );

                                                    if (index >=
                                                            0 &&
                                                        index <
                                                            currentNotes.length) {
                                                      currentNotes.removeAt(
                                                        index,
                                                      );

                                                      await docRef.update({
                                                        'noteM':
                                                            currentNotes,
                                                      });
                                                    }
                                                  }
                                                  _getNoteDoc();

                                                  if (!context
                                                      .mounted) {
                                                    return;
                                                  }
                                                  Navigator.of(
                                                    context,
                                                  ).pop();
                                                  textEditingController
                                                      .clear();
                                                } catch (
                                                  e
                                                ) {
                                                  // print(
                                                  //   e,
                                                  // );
                                                }
                                              },
                                            );
                                          },
                                        );
                                      },
                                      isEdit: isEditOn,
                                      type: type,
                                      text: text,
                                      editNote: () async {
                                        List noteItems =
                                            noteDoc['noteM'];
                                        noteItems[index]['text'];
                                        setTextController(
                                          noteItems[index]['text'],
                                        );
                                        showDialog(
                                          context: context,
                                          builder: (
                                            context,
                                          ) {
                                            return AlertDialog(
                                              title: Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                      top:
                                                          10.0,
                                                    ),
                                                child: Text(
                                                  style: TextStyle(
                                                    color:
                                                        Theme.of(
                                                          context,
                                                        ).colorScheme.primary,
                                                    fontSize:
                                                        18,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                  ),
                                                  'Edit Text Block',
                                                ),
                                              ),
                                              content: Column(
                                                spacing: 15,
                                                mainAxisSize:
                                                    MainAxisSize
                                                        .min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                children: [
                                                  TextFieldMessageEditnote(
                                                    controller:
                                                        textEditingController,
                                                    hint:
                                                        'Enter your note',
                                                    value:
                                                        textEditingController.text,
                                                  ),
                                                  // Column(
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment
                                                  //           .start,
                                                  //   spacing: 10,
                                                  //   mainAxisSize:
                                                  //       MainAxisSize
                                                  //           .min,
                                                  //   children: [
                                                  //     Row(
                                                  //       mainAxisAlignment:
                                                  //           MainAxisAlignment
                                                  //               .start,
                                                  //       children: [
                                                  //         Text(
                                                  //           'Save Type:',
                                                  //         ),
                                                  //       ],
                                                  //     ),
                                                  //     SizedBox(
                                                  //       height:
                                                  //           30,
                                                  //       child: DropdownButton<
                                                  //         String
                                                  //       >(
                                                  //         hint: Text(
                                                  //           'Paragraph',
                                                  //         ),
                                                  //         value:
                                                  //             selectedValue,
                                                  //         onChanged: (
                                                  //           newValue,
                                                  //         ) {
                                                  //           setState(() {
                                                  //             selectedValue =
                                                  //                 newValue;
                                                  //             selectedType =
                                                  //                 newValue!;
                                                  //           });
                                                  //         },
                                                  //         items:
                                                  //             [
                                                  //                   "Title",
                                                  //                   "Sub-title",
                                                  //                   "Paragraph",
                                                  //                 ]
                                                  //                 .map(
                                                  //                   (
                                                  //                     String item,
                                                  //                   ) => DropdownMenuItem<
                                                  //                     String
                                                  //                   >(
                                                  //                     value:
                                                  //                         item,
                                                  //                     child: Text(
                                                  //                       item,
                                                  //                     ),
                                                  //                   ),
                                                  //                 )
                                                  //                 .toList(),
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    spacing:
                                                        10,
                                                    children: [
                                                      MaterialButton(
                                                        onPressed: () async {
                                                          try {
                                                            List
                                                            noteItems =
                                                                noteDoc['noteM'];
                                                            noteItems[index]['text'] =
                                                                textEditingController.text; // Modify the specific item

                                                            await FirebaseFirestore.instance
                                                                .collection(
                                                                  'notes',
                                                                )
                                                                .doc(
                                                                  noteDoc['noteId'],
                                                                )
                                                                .update(
                                                                  {
                                                                    'noteM':
                                                                        noteItems, // Update the modified array back to Firestore
                                                                  },
                                                                );

                                                            // FireStoreService()
                                                            //     .noteDb
                                                            //     .doc(
                                                            //       noteDoc['noteId'],
                                                            //     )
                                                            //     .update({
                                                            //       'noteM': FieldValue.arrayUnion(
                                                            //         [
                                                            //           {
                                                            //             'text':
                                                            //                 textEditingController.text,
                                                            //             'type':
                                                            //                 selectedType,
                                                            //             'time':
                                                            //                 Timestamp.now(),
                                                            //           },
                                                            //         ],
                                                            //       ),
                                                            //     });
                                                            _getNoteDoc();

                                                            if (!context.mounted) {
                                                              return;
                                                            }
                                                            Navigator.of(
                                                              context,
                                                            ).pop();
                                                            textEditingController.clear();
                                                          } catch (
                                                            e
                                                          ) {
                                                            // print(
                                                            //   e,
                                                            // );
                                                          }
                                                        },
                                                        child: Text(
                                                          style: TextStyle(
                                                            color:
                                                                Theme.of(
                                                                  context,
                                                                ).colorScheme.primary,
                                                          ),
                                                          'Save Note',
                                                        ),
                                                      ),
                                                      MaterialButton(
                                                        onPressed: () {
                                                          Navigator.of(
                                                            context,
                                                          ).pop();
                                                        },
                                                        child: Text(
                                                          style: TextStyle(
                                                            color:
                                                                Theme.of(
                                                                  context,
                                                                ).colorScheme.secondary,
                                                          ),
                                                          'Cancel',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),

                //
                //
                //
                //
                //
              ],
            ),
          ),
        ),
      );
    }
  }
}
