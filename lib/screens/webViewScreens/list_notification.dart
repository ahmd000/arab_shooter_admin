import 'package:arab_shooter_admin/firestore_helper/firestore_helper.dart';
import 'package:arab_shooter_admin/helpers/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../config/config.dart';
import '../../helpers/dialog_helper.dart';
import '../../widgets/drawer.dart';
import '../../widgets/text_app.dart';

class ListNotifications extends StatefulWidget {
  const ListNotifications({Key? key}) : super(key: key);

  @override
  State<ListNotifications> createState() => _ListNotificationsState();
}

class _ListNotificationsState extends State<ListNotifications>
    with showDialogHelper, Helpers {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const DrawerWebView(),
      appBar: AppBar(
        elevation: 10.sp,
        backgroundColor: ArabShooter().backgroundColor,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Get.offAllNamed('/web_view_screen'),

              //
              // Navigator.pushNamedAndRemoveUntil(
              // context, "/web_view_screen", (route) => false),
              icon: const Icon(Icons.home))
        ],
        title: TextApp(
          text: "قائمة الإشعارات",
          fontSize: 25.sp,
          fontColor: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.sp,
          vertical: 16.sp,
        ),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirestoreDatabase().getNotify(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                List<QueryDocumentSnapshot> document = snapshot.data!.docs;
                return ListView.builder(
                    itemCount: document.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:  EdgeInsets.symmetric(vertical: 8.sp),
                        child: ListTile(
                          onTap: ()async {
                            await detailDialog(context, document, index);

                          },
                          leading: Image.asset(ArabShooter().pp1),
                          trailing: Icon(Icons.arrow_forward_ios),
                          title: TextApp(
                            text: document[index].get("title_notify"),
                            fontSize: 20.sp,
                            textAlign: TextAlign.start,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 8.sp,
                            vertical: 8.sp,
                          ),
                          tileColor: Colors.black12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.sp),
                          ),
                        ),
                      );
                    });
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications_none_sharp,
                        color: Colors.blueGrey,
                        size: 80.sp,
                      ),
                      TextApp(
                        text: "لا يوجد اشعارات!",
                        fontColor: Colors.blueGrey,
                        fontSize: 30.sp,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }

  Future<void> detailDialog(BuildContext context, List<QueryDocumentSnapshot<Object?>> document, int index) async {
     showAlertDialog(
        context: context,
        title: document[index].get("title_notify"),
        content: Column(
          children: [
            TextApp(
              text:
                  document[index].get("subtitle_notify"),
              fontSize: 20.sp,
              textAlign: TextAlign.start,
            ),
            Image.network(
              document[index].get("image_notify"),
              height: 400.h,
              fit: BoxFit.contain,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: TextApp(
                      text: "حسنا",
                      fontSize: 20.sp,
                      fontColor: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30.0),
                        side: BorderSide(
                            color: ArabShooter()
                                .backgroundColor,
                            width: 2),
                      ),
                      primary:
                          ArabShooter().backgroundColor,
                      padding: EdgeInsets.all(16.sp),
                      fixedSize: const Size(0, 60),
                      alignment:
                          AlignmentDirectional.center,
                      elevation: 10.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await deleteNotify(
                          path: document[index].id);
                      Navigator.pop(context);
                    },
                    child: TextApp(
                      text: "حذف",
                      fontSize: 20.sp,
                      fontColor: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30.0),
                        side: BorderSide(
                            color: ArabShooter()
                                .backgroundColor,
                            width: 2),
                      ),
                      primary: Colors.redAccent,
                      padding: EdgeInsets.all(16.sp),
                      fixedSize: const Size(0, 60),
                      alignment:
                          AlignmentDirectional.center,
                      elevation: 10.sp,
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  Future<void> deleteNotify({required String path}) async {
    bool delete = await FirestoreDatabase().deleteNotify(path: path);
    if (delete) {
      showSnackBar(context: context, message: "تم حذف الاشعار", error: true);
    } else {
      showSnackBar(
          context: context, message: "حدث خطأ ما اثناء الحذف! ", error: false);
    }
  }

}
