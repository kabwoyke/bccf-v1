import 'package:isar/isar.dart';
part 'Notification.g.dart';
@collection
class Notification {
  Id? id;
  String? title;
  String? content;
  bool? read = false;
}
