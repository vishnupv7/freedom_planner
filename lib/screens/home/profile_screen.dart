import 'dart:io';
import 'package:flutter/material.dart';
import 'package:freedom_planner/db/users/user_database.dart';
import 'package:freedom_planner/global/colors.dart';
import 'package:freedom_planner/screens/home/widget/animatedbottomnavigationbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class ProfileScreen extends StatefulWidget {
  final String? name;
  String? image;
  ProfileScreen({this.name, this.image, super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  XFile? imageXfile;
  final ImagePicker _imagePicker = ImagePicker();
  bool check = false;

  Future<void> selectImage() async {
    imageXfile = await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageXfile;
      widget.image =
          imageXfile != null ? imageXfile!.path : widget.image.toString();
    });
    final user = userDatabase();
    await user.addDataTBox(nameController.text,
        imageXfile != null ? imageXfile!.path : widget.image.toString());
  }

  @override
  void initState() {
    nameController.text = widget.name.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Moneymanagerbottomnavigation()));
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 99, 140, 166),
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Moneymanagerbottomnavigation()));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          backgroundColor: const Color.fromARGB(255, 99, 140, 166),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: const Color.fromARGB(255, 99, 140, 166),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const SizedBox(
                  height: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.red,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: Colors.white,
                          ),
                          child: InkWell(
                            onTap: () {
                              selectImage();
                            },
                            child: widget.image == null
                                ? CircleAvatar(
                                    radius: 40.0,
                                    backgroundImage: imageXfile == null
                                        ? null
                                        : FileImage(File(imageXfile!.path)),
                                    backgroundColor: Colors.black12,
                                    child: imageXfile == null
                                        ? Container(
                                            height: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40.0),
                                                color: Colors.black26,
                                                image: const DecorationImage(
                                                  image: AssetImage(
                                                    "lib/assets/images/p1.png",
                                                  ),
                                                  fit: BoxFit.cover,
                                                )),
                                          )
                                        : null,
                                  )
                                : CircleAvatar(
                                    radius: 40.0,
                                    backgroundImage: widget.image == null
                                        ? null
                                        : FileImage(
                                            File(widget.image.toString())),
                                    backgroundColor: Colors.black12,
                                    child: widget.image == null
                                        ? Container(
                                            height: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40.0),
                                                color: Colors.black26,
                                                image: const DecorationImage(
                                                  image: AssetImage(
                                                    "lib/assets/images/p1.png",
                                                  ),
                                                  fit: BoxFit.cover,
                                                )),
                                          )
                                        : null,
                                  ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "UserName",
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            width: 180.0,
                            child: TextFormField(
                              controller: nameController,
                              enabled: check,
                              decoration: const InputDecoration(
                                  hintText: "Your Name",
                                  border: InputBorder.none),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      check
                          ? IconButton(
                              onPressed: () async {
                                if (nameController.text.isNotEmpty) {
                                  final user = userDatabase();
                                  await user.addDataTBox(
                                      nameController.text,
                                      imageXfile != null
                                          ? imageXfile!.path
                                          : widget.image.toString());
                                  setState(() {
                                    check = false;
                                  });
                                  // ignore: use_build_context_synchronously

                                } else {}
                              },
                              icon: const Icon(
                                Icons.done_outline_outlined,
                                color: Colors.black,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  check = true;
                                });
                              },
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: Colors.black,
                              )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  height: MediaQuery.of(context).size.height * 0.48,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            //add code here for Reminder
                          },
                          child: buttonDesign(
                            "Reminder",
                            Colors.purple.withOpacity(0.2),
                            Colors.purple.shade300,
                            Icons.notifications_none,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Divider(
                            color: Colors.black26,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            //add code for share
                          },
                          child: buttonDesign(
                              "Contact me",
                              Colors.purple.withOpacity(0.2),
                              Colors.purple.shade300,
                              Icons.ios_share_rounded),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Divider(
                            color: Colors.black26,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            //add code for reset button
                          },
                          child: buttonDesign(
                              "Reset",
                              Colors.red.shade500.withOpacity(0.2),
                              Colors.red.shade200,
                              Icons.logout),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Divider(
                            color: Colors.black26,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            //code for about butoon
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.scale,
                              dialogType: DialogType.info,
                              body: Center(
                                child: Text(
                                  'If the body is specified, then title and description will be ignored, this allows to 											further customize the dialogue.',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              title: 'This is Ignored',
                              desc: 'This is also Ignored',
                              btnOkOnPress: () {},
                            )..show();
                          },
                          child: buttonDesign(
                              "About",
                              Colors.blueAccent.withOpacity(0.2),
                              Colors.blue.shade200,
                              Icons.info_rounded),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonDesign(
      String text, Color colorCont, Color colorbut, IconData iconData) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50.0,
        decoration: BoxDecoration(
          color: colorCont,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Icon(
            iconData,
            color: colorbut,
            size: 35.0,
          ),
        ),
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      //trailing: Icon(iconEnd),
    );
  }
}
