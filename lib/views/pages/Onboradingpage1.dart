import 'package:flutter/material.dart';
import 'package:insta_app/views/pages/SigninPage.dart';
import 'package:lottie/lottie.dart';

const String lottieFileUrl =
    "assets/images/Office Team Worker saying Hello.json";
const String lottieFileUrl2 = "assets/images/Ai based chatbot discuss.json";
const String lottieFileUrl3 =
    "assets/images/Ai-powered marketing tools abstract.json";
const String lottieFileUrl4 =
    "assets/images/Call Center Support Lottie Animation.json";
const String lottieFileUrl5 = "assets/images/Work from Home.json";
const String lottieFileUrl6 = "assets/images/Research Lottie Animation.json";

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingPagePresenter(
        pages: [
          OnboardingPageModel(
            title: 'Explore WazoMart',
            description: 'Explore how buying and selling works in real time',
            lottieAssetPath: lottieFileUrl4,
            imageUrl: '',
            bgColor: Colors.indigo,
          ),
          OnboardingPageModel(
            title: 'Connect with your friends.',
            description: 'Connect with your friends anytime anywhere.',
            imageUrl: 'https://i.ibb.co/LvmZypG/storefront-illustration-2.png',
            lottieAssetPath: lottieFileUrl,
            bgColor: const Color(0xff1eb090),
          ),
          OnboardingPageModel(
            title: 'Bookmark your favourites',
            description:
                'Bookmark your favourite quotes to read at a leisure time.',
            imageUrl: 'https://i.ibb.co/420D7VP/building.png',
            lottieAssetPath: lottieFileUrl6,
            bgColor: const Color(0xfffeae4f),
          ),
          OnboardingPageModel(
            title: 'Fast, Fluid and Secure',
            description:
                'Enjoy the best of the world in the palm of your hands.',
            imageUrl: 'https://i.ibb.co/cJqsPSB/scooter.png',
            lottieAssetPath: lottieFileUrl2,
            bgColor: Colors.teal,
          ),
          OnboardingPageModel(
            title: 'Work from home',
            description: 'Buying and selling can also be efficient from home ',
            imageUrl: 'https://i.ibb.co/420D7VP/building.png',
            lottieAssetPath: lottieFileUrl3,
            bgColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}

class OnboardingPagePresenter extends StatefulWidget {
  final List<OnboardingPageModel> pages;
  final VoidCallback? onSkip;
  final VoidCallback? onFinish;

  const OnboardingPagePresenter({
    super.key,
    required this.pages,
    this.onSkip,
    this.onFinish,
  });

  @override
  State<OnboardingPagePresenter> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPagePresenter> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: widget.pages[_currentPage].bgColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.pages.length,
                  onPageChanged: (idx) {
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemBuilder: (context, idx) {
                    final item = widget.pages[idx];

                    Widget assetWidget;
                    if (item.lottieAssetPath.isNotEmpty) {
                      assetWidget = Lottie.asset(
                        item.lottieAssetPath,
                        repeat: true,
                        reverse: false,
                        animate: true,
                      );
                    } else {
                      assetWidget = Image.network(item.imageUrl);
                    }

                    return Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: assetWidget,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  item.title,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: item.textColor,
                                      ),
                                ),
                              ),
                              Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 280,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 8.0,
                                ),
                                child: Text(
                                  item.description,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: item.textColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.pages
                    .map(
                      (item) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: _currentPage == widget.pages.indexOf(item)
                            ? 30
                            : 8,
                        height: 8,
                        margin: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    )
                    .toList(),
              ),

              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.comfortable,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Signinpage();
                            },
                          ),
                        );
                      },
                      child: const Text("Skip"),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.comfortable,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        if (_currentPage == widget.pages.length - 1) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Signinpage();
                              },
                            ),
                          );
                        } else {
                          _pageController.animateToPage(
                            _currentPage + 1,
                            curve: Curves.easeInOutCubic,
                            duration: const Duration(milliseconds: 250),
                          );
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            _currentPage == widget.pages.length - 1
                                ? "Finish"
                                : "Next",
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            _currentPage == widget.pages.length - 1
                                ? Icons.done
                                : Icons.arrow_forward,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingPageModel {
  final String title;
  final String description;
  final String imageUrl;
  final String lottieAssetPath; 
  final Color bgColor;
  final Color textColor;

  OnboardingPageModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.lottieAssetPath, 
    this.bgColor = Colors.blue,
    this.textColor = Colors.white,
  });
}
