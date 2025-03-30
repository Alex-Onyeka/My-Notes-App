import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/authentication/login_page.dart';
import 'package:mynotes/class/note_class.dart';
import 'package:mynotes/class/note_item.dart';
import 'package:mynotes/components/add_note_screen.dart';
import 'package:mynotes/components/alert_info.dart';
import 'package:mynotes/components/are_you_sure_alert_box.dart';
import 'package:mynotes/components/edit_name_alertbox.dart';
import 'package:mynotes/components/profile_menu_list.dart';
import 'package:mynotes/provider/theme_provider.dart';
import 'package:mynotes/services/auth_services.dart';
import 'package:mynotes/services/fire_store_service.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  final String userUid;
  const MyProfile({super.key, required this.userUid});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  AuthServices authServices = AuthServices();
  FireStoreService fireStoreService = FireStoreService();

  //
  //
  //
  //

  void logOut() {
    showDialog(
      context: context,
      builder: (context) {
        return AreYouSureAlertBox(
          message:
              'You are attempting to Logout, Are you sure you want to',
          title: 'Are You Sure',
          onPressed: () {
            authServices.logout(context);
          },
        );
      },
    );
  }

  //
  //
  //
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  //
  //
  //
  void addNewNote() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return AddNoteScreen(
          noteController: note,
          titleController: title,
          onPressed: () {
            if (title.text.isEmpty || note.text.isEmpty) {
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
                      text: note.text,
                      type: 'Paragraph',
                    ),
                  ],
                  title: title.text,
                  note: note.text,
                  user: authServices.currentLoggedInUser(),
                ),
              );
              Navigator.of(context).pop();
              if (!context.mounted) {
                return;
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Note Added Successfully!',
                    ),
                  ),
                );
              }
              title.clear();
              note.clear();
            }
          },
        );
      },
    );
  }

  //
  //
  //
  TextEditingController name = TextEditingController();
  //
  void changeName() {
    showDialog(
      context: context,
      builder: (context) {
        return EditNameAlertbox(
          isTwoTextFields: false,
          buttonText: 'Save Name',
          hintMain: 'Enter New Name',
          title: 'Change Your Name',
          nameController: name,
          onPressed: () {
            if (name.text.isEmpty) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertInfo(
                    title: 'Field(s) Empty',
                    message:
                        'You need to fill all fields to Successfully complete action.',
                  );
                },
              );
            } else {
              authServices
                  .currentLoggedInUser()
                  .updateDisplayName(name.text);
              fireStoreService.userDb
                  .doc(
                    authServices.currentLoggedInUser().uid,
                  )
                  .update({'name': name.text});
              if (!context.mounted) {
                return;
              } else {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MyProfile(userUid: uidVar);
                    },
                  ),
                  (route) {
                    return false;
                  },
                );
                name.clear();
              }
            }
          },
        );
      },
    ).then((value) {
      name.clear();
    });
  }

  //
  //
  //
  //
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword =
      TextEditingController();
  //
  void changePassword() {
    showDialog(
      context: context,
      builder: (context) {
        return EditNameAlertbox(
          confirmPassword: confirmPassword,
          buttonText: 'Save Password',
          hintMain: 'Enter New Password',
          hintConfirm: 'Confirm Password',
          isTwoTextFields: true,
          title: 'Change Password',
          nameController: password,
          onPressed: () async {
            if (password.text != confirmPassword.text) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertInfo(
                    title: 'Password Mismatch',
                    message:
                        'Your Password and Confirm Password fields contain different characters',
                  );
                },
              );
            } else if (password.text.isEmpty ||
                confirmPassword.text.isEmpty) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertInfo(
                    title: 'Field(s) Empty',
                    message:
                        'You need to fill all fields to Successfully complete action.',
                  );
                },
              );
            } else {
              await authServices
                  .currentLoggedInUser()
                  .updatePassword(password.text);
              if (!context.mounted) {
                return;
              } else {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MyProfile(userUid: uidVar);
                    },
                  ),
                  (route) {
                    return false;
                  },
                );
                password.clear();
                confirmPassword.clear();
              }
            }
          },
        );
      },
    ).then((value) {
      password.clear();
      confirmPassword.clear();
    });
  }
  //
  //
  //

  @override
  void initState() {
    super.initState();
    _getCurrentUserDoc();
  }

  Map<String, dynamic>? user;
  String uidVar = '';

  Future<void> _getCurrentUserDoc() async {
    var currentUserDoc = await FireStoreService()
        .getNavigatedUserDoc(widget.userUid);
    setState(() {
      user = currentUserDoc!.data();
      uidVar = widget.userUid;
    });
  }

  //
  //
  //
  @override
  void dispose() {
    super.dispose();
    title.dispose();
    note.dispose();
    name.dispose();
    password.dispose();
    confirmPassword.dispose();
  }
  //
  //
  //

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return LoginPage();
        } else {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight:
                  Theme.of(
                    context,
                  ).appBarTheme.toolbarHeight,
              leadingWidth: 80,
              title: Text(
                style: TextStyle(
                  color:
                      Theme.of(
                        context,
                      ).colorScheme.secondary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                'My Profile',
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 20.0,
                  ),
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
            // drawer: MyDrawer(),
            body:
                user == null
                    ? Container(
                      color: const Color.fromARGB(
                        15,
                        0,
                        0,
                        0,
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: const Color.fromARGB(
                            86,
                            255,
                            255,
                            255,
                          ),
                        ),
                      ),
                    )
                    : SingleChildScrollView(
                      child: Column(
                        spacing: 10,
                        mainAxisAlignment:
                            MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            spacing: 5,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(
                                      20,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(
                                            100,
                                          ),
                                      color:
                                          Theme.of(context)
                                              .colorScheme
                                              .tertiaryContainer,
                                    ),
                                    child: Icon(
                                      size: 50,
                                      color:
                                          Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                      Icons.person,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Flexible(
                                child: Text(
                                  textAlign:
                                      TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight:
                                        FontWeight.bold,
                                    color:
                                        Theme.of(context)
                                            .colorScheme
                                            .primary,
                                  ),
                                  user?['name'] ??
                                      'User Name',
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  textAlign:
                                      TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight:
                                        FontWeight.w400,
                                    color:
                                        Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                  ),
                                  user?['email'] ??
                                      'useremail@gmail.com',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 80,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context)
                                      .colorScheme
                                      .surfaceContainer,
                              borderRadius:
                                  BorderRadius.circular(8),
                              border: Border.all(
                                color:
                                    Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer,
                              ),
                            ),
                            child: Column(
                              spacing: 0,
                              children: [
                                StreamBuilder(
                                  stream: fireStoreService
                                      .getUsersNotes(
                                        widget.userUid,
                                      ),
                                  builder: (
                                    context,
                                    snapshot,
                                  ) {
                                    if (!snapshot.hasData) {
                                      return Text('0');
                                    } else {
                                      List docs =
                                          snapshot.data!;
                                      return Text(
                                        style: TextStyle(
                                          color:
                                              Theme.of(
                                                    context,
                                                  )
                                                  .colorScheme
                                                  .primary,
                                          fontSize: 20,
                                          fontWeight:
                                              FontWeight
                                                  .bold,
                                        ),
                                        '${docs.length}',
                                      );
                                    }
                                  },
                                ),
                                Text(
                                  style: TextStyle(
                                    color:
                                        Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                    fontSize: 14,
                                    fontWeight:
                                        FontWeight.w400,
                                  ),
                                  'Total Notes',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                ),
                            child: Column(
                              spacing: 10,
                              children: [
                                ProfileMenuList(
                                  icon: Icons.lock,
                                  isSwitch: false,
                                  onTap: () {
                                    changePassword();
                                  },
                                  title: 'Change Password',
                                  iconTrailing:
                                      Icons
                                          .arrow_forward_ios_rounded,
                                ),
                                ProfileMenuList(
                                  icon: Icons.person,
                                  isSwitch: false,
                                  onTap: () {
                                    changeName();
                                  },
                                  title: 'Change Name',
                                  iconTrailing:
                                      Icons.edit_square,
                                ),
                                ProfileMenuList(
                                  icon: Icons.note_outlined,
                                  isSwitch: false,
                                  onTap: () {
                                    addNewNote();
                                  },
                                  title: 'Create New Note',
                                  iconTrailing: Icons.add,
                                ),
                                ProfileMenuList(
                                  icon: Icons.clear,
                                  isSwitch: false,
                                  onTap: () {
                                    logOut();
                                  },
                                  title: 'Logout',
                                  iconTrailing:
                                      Icons.logout,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
          );
        }
      },
    );
  }
}
