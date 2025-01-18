import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              Container(
                color: Colors.blue,
                child: Image.asset('assets/images/sleep.png'), // Updated to available image
              ),
              Container(
                color: Colors.blue,
                child: Image.asset('assets/images/exercise.png'), // Updated to available image
              ),
              Container(
                color: Colors.blue,
                child: Image.asset('assets/images/work.png'), // Updated to available image
              )
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'tasks');
                  },
                  child: const Text(
                    'skip',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const SwapEffect(
                      dotColor: Colors.blue,
                      activeDotColor: Colors.white,
                      type: SwapType.yRotation),
                ),
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'tasks');
                        },
                        child: const Text('done', style: TextStyle(color: Colors.black)))
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
