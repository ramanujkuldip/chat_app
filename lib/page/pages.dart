import 'package:get/get.dart';
import 'package:push_notification_demo/send_msg.dart';
import 'package:push_notification_demo/users_list.dart';
import 'package:push_notification_demo/utils/constant.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: ROUTE_USERLIST, page: () => const UserList()),
    GetPage(name: ROUTE_USER, page: () => SendMsg()),
  ];
}