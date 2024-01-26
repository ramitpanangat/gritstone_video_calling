import 'package:intl/intl.dart';

class UserModel {
  String? displayName;
  String? userID;
  DateTime? createdOn;

  UserModel({this.displayName, this.userID, this.createdOn});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      displayName: json['displayName'],
      userID: json['uid'],
      createdOn: DateFormat('yyyy-MM-dd hh:mm:ss').parse(json['created_on']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "displayName": displayName,
      "uid": userID,
      "created_on": DateFormat('yyyy-MM-dd hh:mm:ss').format(createdOn!)
    };
  }
}
