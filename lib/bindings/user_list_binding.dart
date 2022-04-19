import 'package:get/get.dart';
import 'package:push_notification_demo/controllers/user_list_controller.dart';

class userListBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => UserListController());
  }
}