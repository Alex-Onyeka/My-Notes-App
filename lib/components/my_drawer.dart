import 'package:flutter/material.dart';
import 'package:mynotes/components/are_you_sure_alert_box.dart';
import 'package:mynotes/components/menu_item_list.dart';
import 'package:mynotes/pages/favorites.dart';
import 'package:mynotes/pages/general_notes.dart';
import 'package:mynotes/pages/home.dart';
import 'package:mynotes/pages/my_profile.dart';
import 'package:mynotes/provider/theme_provider.dart';
import 'package:mynotes/services/auth_services.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  //
  //
  AuthServices authServices = AuthServices();

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
  //
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 70.0,
              bottom: 10,
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text(
                style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.primary,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                'My Notes',
              ),
            ),
          ),
          Expanded(
            child: Column(
              spacing: 5,
              children: [
                Expanded(
                  child: Column(
                    spacing: 5,
                    children: [
                      MenuItemList(
                        icon: Icons.swipe,
                        isSwitch: true,
                        onTap: () {
                          context
                              .read<ThemeProvider>()
                              .changeTheme();
                        },
                        title: 'Switch Theme',
                        trailingIcon:
                            Icons.arrow_forward_ios_rounded,
                      ),
                      MenuItemList(
                        icon: Icons.home,
                        isSwitch: false,
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ),
                          );
                        },
                        title: 'Home',
                        trailingIcon:
                            Icons.arrow_forward_ios_rounded,
                      ),
                      MenuItemList(
                        icon: Icons.person,
                        isSwitch: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => MyProfile(
                                    userUid:
                                        authServices
                                            .currentLoggedInUser()
                                            .uid,
                                  ),
                            ),
                          );
                        },
                        title: 'My Profile',
                        trailingIcon:
                            Icons.arrow_forward_ios_rounded,
                      ),
                      MenuItemList(
                        icon: Icons.favorite_rounded,
                        isSwitch: false,
                        onTap: () {
                          Navigator.of(context)
                            ..pop()
                            ..push(
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        Favorites(),
                              ),
                            );
                        },
                        title: 'Favorites',
                        trailingIcon:
                            Icons.arrow_forward_ios_rounded,
                      ),
                      MenuItemList(
                        icon: Icons.notes_outlined,
                        isSwitch: false,
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return GeneralNotes();
                              },
                            ),
                          );
                        },
                        title: 'View General Notes',
                        trailingIcon:
                            Icons.arrow_forward_ios_rounded,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 30.0,
                  ),
                  child: MenuItemList(
                    icon: Icons.clear,
                    isSwitch: false,
                    onTap: () {
                      logOut();
                    },
                    title: 'Logout',
                    trailingIcon: Icons.logout_rounded,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
