import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gritstone_video_call/components/button_loader.dart';

import '../../constants/palletes.dart';
import '../../constants/route_constants.dart';
import '../../core/firebase_services.dart';
import '../../core/models/user_models.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseFirestore? _firesbaseFirestore;
  TextEditingController? _fullNameController;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  TextEditingController? _cpasswordController;
  String? _fullNameValidateMessage;
  String? _emailValidateMessage;
  String? _passwordValidateMessage;
  String? _cpasswordValidateMessage;
  bool secure = true;
  bool csecure = true;
  bool valid = true;
  bool isSignUpLoading = false;
  User? user;

  checkValidation() async {
    valid = true;
    _fullNameValidateMessage = null;
    _emailValidateMessage = null;
    _passwordValidateMessage = null;
    _cpasswordValidateMessage = null;

    // Check if field is empty
    if (_fullNameController!.text.isEmpty) {
      valid = false;
      _fullNameValidateMessage = "Please enter your name";
    }
    if (_emailController!.text.isEmpty) {
      valid = false;
      _emailValidateMessage = "Please enter your email address";
    }
    if (_passwordController!.text.isEmpty) {
      valid = false;
      _passwordValidateMessage = "Please enter a new password";
    }
    if (_cpasswordController!.text.isEmpty) {
      valid = false;
      _cpasswordValidateMessage = "Please enter confirm password";
    }

    // Check password confirmation
    if (valid) {
      if (_cpasswordController!.text != _passwordController!.text) {
        valid = false;
        _cpasswordValidateMessage = "Password confirmation doesn't match";
      }
    }

    // Sign Up
    if (valid) {
      var data = await _firebaseServices.createAccount(
          _fullNameController!.text,
          _emailController!.text,
          _passwordController!.text);
      if (data is User) {
        user = data;
      }
      if (data is FirebaseAuthException) {
        valid = false;
        switch (data.code) {
          case 'weak-password':
            _cpasswordController!.clear();
            _passwordValidateMessage = data.message;
            break;
          case 'email-already-in-use':
            _emailValidateMessage = data.message;
            break;
          default:
            _firebaseServices.handleErrors(context, data.message);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _cpasswordController = TextEditingController();
    _firesbaseFirestore = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: SvgPicture.asset(
                  "assets/svg/sign_up.svg",
                  width: MediaQuery.sizeOf(context).width * 0.9,
                ),
              ),
              Container(
                  padding: const EdgeInsetsDirectional.all(20),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          "Create Account",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _fullNameController,
                          decoration: const InputDecoration(
                              label: Text(
                                "Full Name",
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                size: 18,
                              )),
                          validator: (value) => _fullNameValidateMessage,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              label: Text(
                                "Email",
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                size: 18,
                              )),
                          validator: (value) => _emailValidateMessage,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: secure,
                          decoration: InputDecoration(
                              label: const Text(
                                "New Password",
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                size: 18,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    secure = !secure;
                                  });
                                },
                                child: Icon(
                                  secure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color:
                                      secure ? Colors.grey[300] : kPrimaryColor,
                                  size: 18,
                                ),
                              )),
                          validator: (value) => _passwordValidateMessage,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextFormField(
                          obscureText: csecure,
                          controller: _cpasswordController,
                          decoration: InputDecoration(
                              label: const Text(
                                "Confirm Password",
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                size: 18,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    csecure = !csecure;
                                  });
                                },
                                child: Icon(
                                  csecure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: csecure
                                      ? Colors.grey[300]
                                      : kPrimaryColor,
                                  size: 18,
                                ),
                              )),
                          validator: (value) => _cpasswordValidateMessage,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    isSignUpLoading = true;
                                  });
                                  await checkValidation();
                                  if (_formKey.currentState!.validate()) {
                                    if (valid && mounted) {
                                      UserModel userInfo = UserModel();
                                      userInfo.displayName =
                                          _fullNameController!.text;
                                      userInfo.createdOn =
                                          user!.metadata.creationTime;
                                      userInfo.userID = user!.uid;
                                      await _firesbaseFirestore!
                                          .collection('Users')
                                          .doc(user!.uid)
                                          .set(userInfo.toJson());
                                      Navigator.popUntil(
                                          context, (route) => route.isFirst);
                                      context.pushReplacementNamed(
                                          RouteNames.home);
                                    }
                                  }
                                  setState(() {
                                    isSignUpLoading = false;
                                  });
                                },
                                child: isSignUpLoading
                                    ? const ButtonLoader()
                                    : Text('Sign Up',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                color: Colors.white,
                                                fontWeight:
                                                    FontWeight.normal))),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have account?",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium),
                                const SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    context.pushNamed(RouteNames.login);
                                  },
                                  child: Text('Login',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.bold)),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
