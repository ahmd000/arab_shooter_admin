import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:arab_shooter_admin/config/config.dart';
import 'package:arab_shooter_admin/helpers/dialog_helper.dart';
import 'package:arab_shooter_admin/helpers/helpers.dart';
import 'package:arab_shooter_admin/model/notification.dart';
import 'package:arab_shooter_admin/notification_controller/fb_notifications.dart';
import 'package:arab_shooter_admin/widgets/button_app.dart';
import 'package:arab_shooter_admin/widgets/button_out_line_app.dart';
import 'package:arab_shooter_admin/widgets/drawer.dart';
import 'package:arab_shooter_admin/widgets/text_app.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../firestore_helper/firestore_helper.dart';

class SendNotificationScreen extends StatefulWidget {
  const SendNotificationScreen({Key? key}) : super(key: key);

  @override
  _SendNotificationScreenState createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen>
    with Helpers, FbNotifications, showDialogHelper, FlushbarHelper {
  late TextEditingController _titleEditController;
  late TextEditingController _subTitleEditController;
  File? _image;
  final _picker = ImagePicker();
  bool isLoading = false;
  String imageNotifyID = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  forgroundFirebaseMessaging();
    _titleEditController = TextEditingController();
    _subTitleEditController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleEditController.dispose();
    _subTitleEditController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // drawer: const DrawerWebView(),
      appBar: AppBar(
        elevation: 10.sp,
        backgroundColor: ArabShooter().backgroundColor,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Get.offAllNamed('/web_view_screen'),

              // Navigator.pushNamedAndRemoveUntil(
              // context, "/web_view_screen", (route) => false),
              icon: const Icon(Icons.home))
        ],
        title: TextApp(
          text: "الإشعارات",
          fontSize: 25.sp,
          fontColor: Colors.white,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
        child: ListView(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: InkWell(
                onTap: () {
                  openGallery();
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: _image != null
                        ? DecorationImage(
                            image: FileImage(
                              _image!,
                            ),
                            fit: BoxFit.cover,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(15.sp),
                    color: Colors.black12,
                  ),
                  child: _image == null
                      ? Center(
                          child: Icon(
                          Icons.add_photo_alternate,
                          size: 70.sp,
                          color: ArabShooter().backgroundColor,
                        ))
                      : null,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Column(
                children: [
                  TextField(
                    controller: _titleEditController,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: "Tajawal",
                      fontSize: 23.sp,
                    ),
                    decoration: InputDecoration(
                      hintText: "عنوان الاشعار",
                      labelStyle: TextStyle(
                        fontFamily: "Tajawal",
                        fontSize: 23.sp,
                      ),
                      hintStyle: TextStyle(
                        fontFamily: "Tajawal",
                        fontSize: 20.sp,
                      ),
                      prefixIcon: const Icon(Icons.title),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.sp),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
                    controller: _subTitleEditController,
                    keyboardType: TextInputType.multiline,
                    textAlign: TextAlign.start,
                    minLines: 3,
                    maxLines: 5,
                    style: TextStyle(
                      fontFamily: "Tajawal",
                      fontSize: 23.sp,
                    ),
                    decoration: InputDecoration(
                      hintText: "موضوع الاشعار",
                      labelStyle: TextStyle(
                        fontFamily: "Tajawal",
                        fontSize: 23.sp,
                      ),
                      hintStyle: TextStyle(
                        fontFamily: "Tajawal",
                        fontSize: 20.sp,
                      ),
                      prefixIcon: const Icon(Icons.subtitles),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.sp),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            isLoading == false
                ? SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        uploadImageAndSaveItemInfo();
                      },
                      label: TextApp(
                        text: "ارسال الاشعار",
                        fontSize: 20.sp,
                        fontColor: Colors.white,
                      ),
                      icon: const Icon(Icons.send),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(0, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(
                              color: ArabShooter().backgroundColor, width: 2),
                        ),
                        primary: ArabShooter().backgroundColor,
                        padding: EdgeInsets.all(16.sp),
                        fixedSize: const Size(0, 60),
                        alignment: AlignmentDirectional.center,
                        elevation: 10.sp,
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }

  void sendNotify(BuildContext context, String imageCloseUpDownloadURL) {
    if (_titleEditController.text.isNotEmpty &&
        _subTitleEditController.text.isNotEmpty) {
      sendGeneralNotify(_titleEditController.text.trim(),
          _subTitleEditController.text.trim(), imageCloseUpDownloadURL);
      showSnackBar(
        context: context,
        message: "تم ارسال الاشعار",
        error: false,
      );

      clearText();
    } else {
      showSnackBar(
        context: context,
        message: "أكمل جميع الحقول!",
        error: true,
      );
    }
  }

  openGallery() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void clearText() {
    setState(() {
      _subTitleEditController.clear();
      _titleEditController.clear();
      _image = null;
    });
  }

  uploadImageAndSaveItemInfo() async {
    setState(() {
      isLoading = true;
    });
    String imageCloseUpDownloadURL = await uploadImageCloseUp(_image);
    saveItemInfo(imageCloseUpDownloadURL);
    sendNotify(context, imageCloseUpDownloadURL);
    clearText();
    setState(() {
      isLoading = false;
    });
  }

  uploadImageCloseUp(mFileImage) async {
    final Reference reference =
        FirebaseStorage.instance.ref().child('Notification Images');
    UploadTask task = reference
        .child('Notification Images:$imageNotifyID')
        .putFile(mFileImage);
    TaskSnapshot taskSnapshot = await task.whenComplete(() {
      print('Image Notification is Uploaded $task');
    });
    String closeUpDownloadURL = await taskSnapshot.ref.getDownloadURL();
    print(closeUpDownloadURL);
    return closeUpDownloadURL;
  }

  void saveItemInfo(String imageCloseUpDownloadURL) {
    if (_titleEditController.text.isNotEmpty &&
        _subTitleEditController.text.isNotEmpty &&
        _image != null) {
      FirestoreDatabase().firestore.collection("notification").add({
        "title_notify": _titleEditController.text,
        "subtitle_notify": _subTitleEditController.text,
        "image_notify": imageCloseUpDownloadURL,
        "created_at": DateTime.now(),
      });
    }
  }
}
