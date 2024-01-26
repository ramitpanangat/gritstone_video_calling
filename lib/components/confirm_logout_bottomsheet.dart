import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:gritstone_video_call/components/button_loader.dart';
import 'package:gritstone_video_call/constants/palletes.dart';
import 'package:gritstone_video_call/core/firebase_services.dart';

class ConfirmLogout extends StatefulWidget {
  const ConfirmLogout({super.key});

  @override
  State<ConfirmLogout> createState() => _ConfirmLogoutState();
}

class _ConfirmLogoutState extends State<ConfirmLogout> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Confirm",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: kPrimaryColor),
                ),
                IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(FontAwesomeIcons.xmark))
              ],
            ),
            const Divider(
              color: kPrimaryColor,
            ),
            Text(
              "Are you sure you want to logout?",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize:
                                Size(MediaQuery.sizeOf(context).width, 50),
                            backgroundColor: Colors.white),
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: kPrimaryColor),
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize:
                                Size(MediaQuery.sizeOf(context).width, 50),
                          ),
                          onPressed: () async {
                            await _firebaseServices.logout(context);
                          },
                          child: isLoading
                              ? const ButtonLoader()
                              : Text("Confirm",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white)))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
