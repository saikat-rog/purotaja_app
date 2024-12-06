import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopBannerController extends GetxController {
  RxBool isVisible = false.obs;
  RxString message = ''.obs;

  void show(String text) {
    message.value = text;
    isVisible.value = true;

    // Automatically hide after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      hide();
    });
  }

  void hide() {
    isVisible.value = false;
  }
}

class TopBanner extends StatelessWidget {
  const TopBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<TopBannerController>();
      return controller.isVisible.value
          ? Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: 100,
          color: Colors.red,
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              controller.message.value,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      )
          : const SizedBox.shrink();
    });
  }
}
