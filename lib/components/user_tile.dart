import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:gritstone_video_call/constants/palletes.dart';
import 'package:gritstone_video_call/constants/route_constants.dart';

import '../core/models/user_models.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text(user.displayName![0])),
        title: Text(user.displayName!),
        trailing: IconButton(
          icon: const Icon(
            FontAwesomeIcons.video,
            size: 25,
            color: kPrimaryColor,
          ),
          onPressed: () {
            context.pushNamed(RouteNames.videoCall);
          },
        ),
      ),
    );
  }
}
