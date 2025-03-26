import 'package:flutter/material.dart';
import 'package:mynotes/authentication/login_page.dart';
import 'package:mynotes/components/button.dart';
import 'package:mynotes/components/radio_button_list_tile.dart';
import 'package:mynotes/components/text_field_main.dart';
import 'package:mynotes/components/text_field_message.dart';
import 'package:mynotes/provider/main_provider.dart';
import 'package:mynotes/services/auth_services.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //
  //
  //
  AuthServices authServices = AuthServices();
  //
  //
  //
  TextEditingController nameController =
      TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword =
      TextEditingController();
  //
  //
  //

  //
  //
  //
  void createNewUser() async {
    await authServices.createUserAccount(
      gender: selectedGender,
      userName: nameController.text,
      email: email.text,
      password: password.text,
      confirmPassword: confirmPassword.text,
      context: context,
    );
  }

  //
  //
  List options = ["Rather Not Say", 'Male', 'Female'];
  int selectedValue = 0;
  String selectedGender = 'Rather Not Say';

  //
  //
  //
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  spacing: 20,
                  mainAxisAlignment:
                      MainAxisAlignment.center,
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
                          'Create Your Account',
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
                          TextFieldMessage(
                            hint: 'Enter your name',
                            icon: Icons.person,
                            maxLines: 1,
                            controller: nameController,
                          ),
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
                          TextFieldMain(
                            notCapitalize: true,
                            password: true,
                            hint: 'Confirm Password',
                            controller: confirmPassword,
                            icon: Icons.lock_outline,
                          ),
                          SizedBox(
                            height: 50,
                            width: 400,
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceEvenly,
                              children: [
                                RadioButtonListTile(
                                  value: 0,
                                  onTap: () {
                                    setState(() {
                                      selectedValue = 0;
                                      selectedGender =
                                          options[0];
                                    });
                                    // print(selectedGender);
                                  },
                                  selectedValue:
                                      selectedValue,
                                  title: options[0],
                                ),
                                RadioButtonListTile(
                                  value: 1,
                                  onTap: () {
                                    setState(() {
                                      selectedValue = 1;
                                      selectedGender =
                                          options[1];
                                    });
                                    // print(selectedGender);
                                  },
                                  selectedValue:
                                      selectedValue,
                                  title: options[1],
                                ),
                                RadioButtonListTile(
                                  value: 2,
                                  onTap: () {
                                    setState(() {
                                      selectedValue = 2;
                                      selectedGender =
                                          options[2];
                                    });
                                    // print(selectedGender);
                                  },
                                  selectedValue:
                                      selectedValue,
                                  title: options[2],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Button(
                      title: 'Sign Up',
                      onTap: () {
                        // print(selectedGender);
                        createNewUser();
                        // print(selectedGender);
                      },
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => LoginPage(),
                          ),
                        );
                      },
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
                              'Do you have Account?',
                            ),
                            Text(
                              style: TextStyle(
                                color: Colors.teal.shade500,
                                fontWeight: FontWeight.bold,
                              ),
                              'Login',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible:
                  context.watch<MainProvider>().isLoading,
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
