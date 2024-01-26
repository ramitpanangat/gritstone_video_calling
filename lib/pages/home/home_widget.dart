import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:gritstone_video_call/config/custom_bottomsheet.dart';
import 'package:gritstone_video_call/constants/palletes.dart';
import 'package:gritstone_video_call/constants/route_constants.dart';
import 'package:gritstone_video_call/core/firebase_services.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseServices? _firebaseServices;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseServices = FirebaseServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            "Video Call",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await CustomBottomsheet.confirmLogout(context);
              },
              icon: const Icon(
                FontAwesomeIcons.powerOff,
                color: kPrimaryColor,
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              "Join Us",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: kPrimaryColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
            child: Text(
              "Tap on 'Join Room' to enjoy our discussion.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          Expanded(
              child: Container(
                  child:
                      Lottie.asset("assets/lottie/home.json", repeat: true))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed(RouteNames.videoCall);
                  },
                  child: Text('Join Room',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.normal))),
            ),
          )
        ],
      ),
    );
  }
}
