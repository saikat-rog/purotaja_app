import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OnBoardingController {
  // Tracks the current image index
  var currentIndex = 0.obs;
  var currentIndex2 = 0.obs;

  // List of onboarding images
  final List<String> onboardingImages = [
    'assets/onboarding1.svg',
    'assets/onboarding2.svg',
    'assets/onboarding3.svg',
  ];

  final List<String> slideImages = [
    'assets/slide1.svg',
    'assets/slide2.svg',
    'assets/slide3.svg',
  ];

  final List<String> onBoardingTextsHeading = [
    'Freshness Redefined',
    'Hassle-Free Experience',
    'Your Health, Our Priority',
  ];

  final List<String> onBoardingTextsSubHeading1 = [
    'Experience the freshest catch, straight',
    'Order fresh fish easily and get it delivered on time.',
    'Enjoy clean, nutritious fish packed with care for your family.',
  ];

  final List<String> onBoardingTextsSubHeading2 = [
    'straight from the waters to your home.',
    'on time.',
    'care for your family.',
  ];

  // Function to go to the next image
  void nextImage() {
    if (currentIndex.value < onboardingImages.length - 1) {
      currentIndex.value++;
      currentIndex2.value++;
    } else {
      // Navigate to the next screen after the last image
      Get.offNamed('/auth');
    }
  }
}

class OnBoardingScreen extends StatelessWidget {
  final OnBoardingController controller = Get.put(OnBoardingController());

  OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // The content of the screen (image, texts)
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // AnimatedSwitcher for image change with fade animation
                      SizedBox(
                        height: 300,
                        child: Obx(() => SvgPicture.asset(
                              controller.onboardingImages[
                                  controller.currentIndex.value],
                              key: ValueKey<int>(controller.currentIndex
                                  .value), // Key to trigger the animation
                            )),
                      ),
                      const SizedBox(
                          height: 40), // Spacing between image and text
                      Obx(() => Text(
                            controller.onBoardingTextsHeading[
                                controller.currentIndex.value],
                            key: ValueKey<int>(controller.currentIndex.value),
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          )),
                      const SizedBox(height: 10), // Spacing between lines
                      Obx(() => Text(
                            controller.onBoardingTextsSubHeading1[
                                controller.currentIndex.value],
                        key: ValueKey<int>(controller.currentIndex.value),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // The indicator or slide image
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(
              () => SvgPicture.asset(
                key: ValueKey<int>(controller.currentIndex.value),
                controller.slideImages[controller.currentIndex.value],
              ),
            ),
          ),
          const SizedBox(height: 30),
          // NEXT button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: controller.nextImage,
                child: Obx(() {
                  // Fix for showing the correct button text
                  return Text(
                    key: ValueKey<int>(controller.currentIndex.value),
                    controller.currentIndex.value ==
                            controller.onboardingImages.length - 1
                        ? 'Get Started'
                        : 'Next',
                  );
                }),
              ),
            ),
          ),
          // Skip button
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: GestureDetector(
              onTap: () {
                Get.offNamed('/auth');
              },
              child: Text(
                'Skip',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
