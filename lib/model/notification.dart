import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? uid;
  String? titleNotify;
  String? subtitleNotify;
  String? imageUrlNotify;

  NotificationModel();

  NotificationModel.fromMap(Map<String, dynamic> documentMap) {
    // uid = map.id;
    titleNotify = documentMap['title_notify'];
    subtitleNotify = documentMap['subtitle_notify'];
    imageUrlNotify = documentMap['image_notify'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['title_notify'] = titleNotify;
    map['subtitle_notify'] = subtitleNotify;
    map['image_notify'] = imageUrlNotify;
    return map ;
  }
}
