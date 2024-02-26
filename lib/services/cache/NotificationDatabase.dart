import 'package:bccf/services/cache/Notification.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NotificationDatabase {
  static late Isar isar;
  static Future<void> init() async{
    final documentsDir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NotificationSchema], directory: documentsDir.path);
  }

  final List<Notification> announcements = [];

  static Future<void> addNotification(int id ,String title , String content) async {
    final new_id = Notification()..id = id;
    final new_title = Notification()..title = title;
    final new_content = Notification()..title = content;

    await isar.writeTxn(() => isar.notifications.put(new_id));
    await isar.writeTxn(() => isar.notifications.put(new_title));
    await isar.writeTxn(() => isar.notifications.put(new_content));
      
  }

  static Future<List<Notification>> fetchNotification()async{
    List<Notification> fetchedNotifications = await isar.notifications.where().findAll();
    return fetchedNotifications;
  }

  static Future<List<Notification>> findById(int id) async{
    final result = await isar.notifications.where().idEqualTo(id).findAll();
    return result;
  }
}