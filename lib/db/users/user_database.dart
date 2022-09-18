import 'package:freedom_planner/model/user/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class userDatabase {
  Future<void> addDataTBox(String name, String imagePath) async {
    final dbox = await Hive.openBox("userDataDatabase");
    final db = Hive.box("userDataDatabase");
    final user = userModel()
      ..userName = name
      ..profilePic = imagePath;

    final box = db.put(1, user);
  }

  Future<userModel> readvalues() async {
    final dbox = await Hive.openBox("userDataDatabase");
    final read = Hive.box("userDataDatabase");
    userModel data = await read.get(1);
    // print("------- ${data.profilePic}");
    // print("------- ${data.userName}");
    return data;
  }
}
