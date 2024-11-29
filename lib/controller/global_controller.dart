import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxBool canLeaveApp = false.obs;
  final RxList<int> _indexStack = <int>[].obs;

  List<int> get indexStack => _indexStack;

  set indexStack(List<int> value) {
    canLeaveApp = false.obs;
    currentIndex.value = value[0];
    if (_indexStack.isNotEmpty && _indexStack.last == value[0]) {
      return;
    }
    _indexStack.addAll(value);
    print(_indexStack);
    // _indexStack.addAllIf(_indexStack.last != value[0], value);
  }

  void clearIndexStack() {
    _indexStack.clear();
    currentIndex = 0.obs;
  }

  void popIndexStack(BuildContext context) {
    if (indexStack.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Go back again to exit the app'),
          dismissDirection: DismissDirection.down,
        ),
      );
      if (currentIndex == 0.obs) {
        canLeaveApp = true.obs;
      }
      currentIndex = 0.obs;
    } else {
      _indexStack.removeLast();
      currentIndex = _indexStack.isEmpty ? 0.obs : _indexStack.last.obs;
    }
  }
}
