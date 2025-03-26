import 'package:flutter/material.dart';
import 'package:mynotes/authentication/sign_up_page.dart';
import 'package:mynotes/components/button.dart';
import 'package:mynotes/components/text_field_main.dart';
import 'package:mynotes/services/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //
  //
  //
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  AuthServices authServices = AuthServices();
  //
  //
  //
  bool isLoading = false;

  //
  //
  void loginUser() async {
    setState(() {
      isLoading = true;
    });

    await authServices.loginUser(
      email: email.text,
      password: password.text,
      context: context,
    );
    setState(() {
      isLoading = false;
    });
  }
  //
  //

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Text(
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      'Please Login',
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                  ),
                  child: Column(
                    spacing: 15,
                    children: [
                      TextFieldMain(
                        notCapitalize: true,
                        password: false,
                        hint: 'Enter Email',
                        controller: email,
                        icon: Icons.email_outlined,
                      ),
                      TextFieldMain(
                        notCapitalize: true,
                        password: true,
                        hint: 'Enter Password',
                        controller: password,
                        icon: Icons.lock_outline,
                      ),
                    ],
                  ),
                ),
                Button(
                  title: 'Login',
                  onTap: () {
                    loginUser();
                  },
                ),
                InkWell(
                  onTap:
                      () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => SignUpPage(),
                        ),
                      ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Text(
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                          'Don\'t have Account?',
                        ),
                        Text(
                          style: TextStyle(
                            color: Colors.teal.shade500,
                            fontWeight: FontWeight.bold,
                          ),
                          'Sign Up',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
        ),
      ),
    );
  }
}
