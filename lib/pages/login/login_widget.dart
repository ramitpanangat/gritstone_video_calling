import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:gritstone_video_call/components/button_loader.dart';
import 'package:gritstone_video_call/core/models/user_models.dart';
import '../../constants/palletes.dart';
import '../../constants/route_constants.dart';
import '../../core/firebase_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseServices _firebaseServices = FirebaseServices();
  FirebaseFirestore? _firesbaseFirestore;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  User? user;
  String? emailValidationMessage;
  String? passwordValidationMessage;
  bool secure = true;
  bool valid = true;
  bool isLoginLoading = false;
  bool isGoogleLoginLoading = false;

  validateLogin() async {
    valid = true;
    emailValidationMessage = null;
    passwordValidationMessage = null;

    // Check if fields are filled
    if (_emailController!.text.isEmpty) {
      valid = false;
      emailValidationMessage = 'Please enter your email';
    }
    if (_passwordController!.text.isEmpty) {
      valid = false;
      passwordValidationMessage = 'Please enter your password';
    }

    // Try login
    if (valid) {
      var data = await _firebaseServices.login(
          _emailController!.text, _passwordController!.text);
      if (data is FirebaseAuthException) {
        valid = false;
        switch (data.code) {
          case 'invalid-credential':
            passwordValidationMessage = 'Invalid credentials';
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
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _firesbaseFirestore = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Center(
                child: SvgPicture.asset(
              "assets/svg/login.svg",
              width: MediaQuery.sizeOf(context).width * 0.9,
            )),
          ),
          Container(
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            padding: const EdgeInsetsDirectional.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.titleMedium,
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
                            Icons.person,
                            size: 18,
                          )),
                      validator: (value) => emailValidationMessage,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: secure,
                      decoration: InputDecoration(
                          label: const Text(
                            "Password",
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
                              secure ? Icons.visibility_off : Icons.visibility,
                              color: secure ? Colors.grey[300] : kPrimaryColor,
                              size: 18,
                            ),
                          )),
                      validator: (value) => passwordValidationMessage,
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
                                isLoginLoading = true;
                              });
                              await validateLogin();
                              if (_formKey.currentState!.validate()) {
                                if (valid && mounted) {
                                  Navigator.popUntil(
                                      context, (route) => route.isFirst);
                                  context.pushReplacementNamed(RouteNames.home);
                                } else {
                                  setState(() {
                                    isLoginLoading = false;
                                  });
                                }
                              } else {
                                setState(() {
                                  isLoginLoading = false;
                                });
                              }
                            },
                            child: isLoginLoading
                                ? const ButtonLoader()
                                : Text("Login",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: isGoogleLoginLoading
                            ? Container(
                                height: 50,
                                width: MediaQuery.sizeOf(context).width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: kPrimaryColor.withOpacity(0.5)),
                                child: const ButtonLoader(),
                              )
                            : TextButton.icon(
                                icon: const Icon(FontAwesomeIcons.google,
                                    color: Colors.white),
                                onPressed: () async {
                                  setState(() {
                                    isGoogleLoginLoading = true;
                                  });
                                  var loginData = await _firebaseServices
                                      .signInWithGoogle();

                                  if (loginData is User) {
                                    user = loginData;
                                    valid = true;
                                  } else {
                                    setState(() {
                                      isGoogleLoginLoading = false;
                                    });
                                    valid = false;
                                  }
                                  if (valid && mounted) {
                                    UserModel userInfo = UserModel();
                                    userInfo.displayName = user!.displayName;
                                    userInfo.createdOn =
                                        user!.metadata.creationTime;
                                    userInfo.userID = user!.uid;
                                    await _firesbaseFirestore!
                                        .collection('Users')
                                        .doc(user!.uid)
                                        .set(userInfo.toJson());
                                    Navigator.popUntil(
                                        context, (route) => route.isFirst);
                                    context
                                        .pushReplacementNamed(RouteNames.home);
                                  }
                                },
                                label: Text("Sign In with Google",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white)),
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    fixedSize: Size(
                                        MediaQuery.sizeOf(context).width, 50),
                                    backgroundColor:
                                        kPrimaryColor.withOpacity(0.5)),
                              ),
                      ),
                      TextButton(
                          onPressed: () {
                            context.pushNamed(RouteNames.signUp);
                          },
                          child: Text(
                            "Create Account",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
