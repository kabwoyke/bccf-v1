import 'package:isar/isar.dart';
part 'AnnouncementNotification.g.dart';
@collection
class AnnouncementNotification {
  Id? id;
  String? title;
  String? content;
  bool? read;
  AnnouncementNotification({ this.title ,  this.content , required this.id , this.read = false});
}
