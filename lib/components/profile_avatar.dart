import 'package:flutter/material.dart';
import 'package:mynotes/pages/my_profile.dart';
import 'package:mynotes/services/auth_services.dart';

class ProfileAvatar extends StatelessWidget {
  final bool isProfile;
  const ProfileAvatar({super.key, required this.isProfile});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isProfile) {
          return;
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => MyProfile(
                    userUid:
                        AuthServices()
                            .currentLoggedInUser()
                            .uid,
                  ),
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 5),
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Icon(
          size: 25,
          color:
              Theme.of(context).colorScheme.inversePrimary,
          Icons.person,
        ),
      ),
    );
  }
}
