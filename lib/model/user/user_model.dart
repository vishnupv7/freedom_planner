import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 7)
class userModel {
  @HiveField(0)
  late String? userName;
  @HiveField(1)
  late String? profilePic;

  userModel({
    this.userName,
    this.profilePic,
  });
}
