import 'package:flutter/material.dart';
import 'package:gritstone_video_call/components/confirm_logout_bottomsheet.dart';

class CustomBottomsheet {
  static confirmLogout(
    BuildContext context,
  ) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        context: context,
        builder: (context) {
          return  ConfirmLogout();
        });
  }
}
