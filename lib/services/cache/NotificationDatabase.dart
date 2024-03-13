import 'package:bccf/services/cache/AnnouncementNotification.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';


import 'package:bccf/services/cache/AnnouncementNotification.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NotificationDatabase extends ChangeNotifier {
  static final NotificationDatabase _instance = NotificationDatabase._internal();
  static late final Isar isar;
  final List<AnnouncementNotification> announcements = [];
  var notificationCount = 0;

  // Private constructor
  NotificationDatabase._internal();

  // Factory constructor to return the same instance
  factory NotificationDatabase() {
    return _instance;
  }

  // Initialization method, can still be called directly if needed
  static Future<void> init() async {
    final documentsDir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([AnnouncementNotificationSchema], directory: documentsDir.path);
  }

  Future<void> fetchNotification() async {
    List<AnnouncementNotification> fetchedNotifications = await isar.announcementNotifications.where().findAll();
    announcements.clear();
    announcements.addAll(fetchedNotifications.reversed);
    print(fetchedNotifications[0].id);
    notificationCount = announcements.length;
    notifyListeners();
  }

  Future<void> addNotification(AnnouncementNotification noti) async {
    final newAnnouncement = AnnouncementNotification(id: noti.id, title: noti.title, content: noti.content);
    await isar.writeTxn(() async {
      await isar.announcementNotifications.put(newAnnouncement);
      print("inserted");
    });
    await fetchNotification();
    notificationCount = announcements.length;
    notifyListeners();
  }

  void startListeningToNotifications() {
    // Assuming `announcementNotifications` is your Isar collection
    final stream = isar.announcementNotifications.watchLazy();

    stream.listen((_) async {
      await fetchNotification(); // This will update `announcements` and `notificationCount`
      notifyListeners(); // This notifies all the listeners about the change.
    });
  }


  static Future<void> close() async {
    await isar.close(); // This closes the Isar instance
  }
}


// class NotificationDatabase extends ChangeNotifier {
//   static late Isar isar;
//   final List<AnnouncementNotification> announcements = [];
//   static Future<void> init() async{
//     final documentsDir = await getApplicationDocumentsDirectory();
//     isar = await Isar.open([AnnouncementNotificationSchema], directory: documentsDir.path);
//   }
//   var notificationCount = 0;
//   Future<void> fetchNotification() async {
//     List<AnnouncementNotification> fetchedNotifications = await isar.announcementNotifications.where().findAll();
//     announcements.clear();
//     announcements.addAll(fetchedNotifications.reversed);
//     print(fetchedNotifications[0].id);
//     notificationCount = announcements.length;
//     notifyListeners();
//
//   }
//     Future<void> addNotification(AnnouncementNotification noti) async {
//     final newAnnouncement = AnnouncementNotification(id: noti.id , title: noti.title , content: noti.content);
//     await isar.writeTxn(() async {
//       await isar.announcementNotifications.put(newAnnouncement);
//       print("inserted");
//
//     });
//     await fetchNotification();
//     notificationCount = announcements.length;
//     notifyListeners();
//   }
//
//   void inc(){
//     notificationCount+=1;
//     notifyListeners();
//   }
//
//   static Future<void> close() async {
//     await isar.close(); // This closes the Isar instance
//   }
//
// }