import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../constants/route_constants.dart';
import '../../core/firebase_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool?>(
          future: _firebaseServices.checkAuthentication(),
          builder: (context, userData) {
            if (userData.connectionState != ConnectionState.waiting) {
              if (userData.data!) {
                Future.microtask(
                    () => context.pushReplacementNamed(RouteNames.home));
              } else {
                Future.microtask(
                    () => context.pushReplacementNamed(RouteNames.welcome));
              }
            }
            return Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Lottie.asset("assets/lottie/loading.json", repeat: true),
            ));
          }),
    );
  }
}
