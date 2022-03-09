import 'package:arab_shooter_admin/model/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabase {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<bool> createNotify({required NotificationModel notify}) async {
    try {
      await firestore
          .collection("notification")
          .add(notify.toMap())
          .then((value) => true)
          .catchError((e) => false);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteNotify({required String path}) {
    return firestore
        .collection("notification")
        .doc(path)
        .delete()
        .then((value) => true)
        .catchError((e) => false);
  }

  Future<bool> updateNotify({required NotificationModel notify}) {
    return firestore
        .collection("notification")
        .doc(notify.uid)
        .update(notify.toMap())
        .then((value) => true)
        .catchError((e) => false);
  }

  Stream<QuerySnapshot> getNotify() async* {
    yield* firestore.collection("notification").orderBy("created_at").snapshots();
  }
}
