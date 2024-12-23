import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OnBoardingController {
  var currentIndex = 0.obs;

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

  void nextImage() {
    if (currentIndex.value < onboardingImages.length - 1) {
      currentIndex.value++;
    } else {
      Get.offNamed('/auth');
    }
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }
}

class OnBoardingScreen extends StatelessWidget {
  final OnBoardingController controller = Get.put(OnBoardingController());

  OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    PageController _pageController = PageController();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.35,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: controller.onboardingImages.length,
                        onPageChanged: controller.onPageChanged,
                        itemBuilder: (context, index) {
                          return SvgPicture.asset(
                            controller.onboardingImages[index],
                            key: ValueKey<int>(index),
                            width: screenWidth * 0.5,
                            fit: BoxFit.contain,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    Padding(padding: EdgeInsets.symmetric(horizontal: screenWidth*0.06),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(() => Text(
                          controller.onBoardingTextsHeading[controller.currentIndex.value],
                          key: ValueKey<int>(controller.currentIndex.value),
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.06),
                        )),
                        SizedBox(height: screenHeight * 0.01),
                        Obx(() => Text(
                          controller.onBoardingTextsSubHeading1[controller.currentIndex.value],
                          key: ValueKey<int>(controller.currentIndex.value),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: screenWidth * 0.045),
                        )),
                      ],
                    ),)
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Obx(() => SvgPicture.asset(
              key: ValueKey<int>(controller.currentIndex.value),
              controller.slideImages[controller.currentIndex.value],
              height: screenHeight * 0.015,
              fit: BoxFit.contain,
            )),
          ),
          SizedBox(height: screenHeight * 0.03),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
            child: SizedBox(
              width: double.infinity,
              height: screenHeight * 0.07,
              child: ElevatedButton(
                onPressed: controller.nextImage,
                child: Obx(() {
                  return Text(
                    key: ValueKey<int>(controller.currentIndex.value),
                    controller.currentIndex.value == controller.onboardingImages.length - 1
                        ? 'Get Started'
                        : 'Next',
                    style: TextStyle(fontSize: screenWidth * 0.045),
                  );
                }),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.03),
            child: GestureDetector(
              onTap: () {
                Get.offNamed('/auth');
              },
              child: Text(
                'Skip',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).primaryColor, fontSize: screenWidth * 0.045),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
