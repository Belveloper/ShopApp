import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/constants/constants.dart';
import 'package:shopapp/views/login_Screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  String? image;
  String? title;
  String? description;
  BoardingModel(
      {required this.image, required this.title, required this.description});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var cache = Hive.box('Local');
  PageController controller = PageController();
  bool isLast = false;
  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'lib/assets/images/onBoarding.png',
        title: 'On Boarding screen # 1 ',
        description:
            'On Boarding title description to introduce what this app does ... 1'),
    BoardingModel(
        image: 'lib/assets/images/onBoarding.png',
        title: 'On Boarding screen # 2 ',
        description:
            'On Boarding title description to introduce what this app does ...2'),
    BoardingModel(
        image: 'lib/assets/images/onBoarding.png',
        title: 'On Boarding screen # 3 ',
        description:
            'On Boarding title description to introduce what this app does ...3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(actions: [
        TextButton(
          onPressed: () {
            submit();
          },
          child: const Text(
            'SKIP',
            style: TextStyle(
              fontFamily: 'Righteous',
              fontSize: 15,
              color: Colors.deepOrange,
            ),
          ),
        )
      ]),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: controller,
                  onPageChanged: ((index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        print('isLast:$isLast');
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        print('isLast:$isLast');
                        isLast = false;
                      });
                    }
                  }),
                  itemBuilder: ((context, index) =>
                      buildBoardingItem(boarding[index])),
                  itemCount: boarding.length,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    effect: const ExpandingDotsEffect(
                        dotHeight: 10,
                        expansionFactor: 3,
                        spacing: 5,
                        activeDotColor: Colors.orange),
                    controller: controller,
                    count: boarding.length,
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    backgroundColor: Colors.deepOrange,
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        controller.nextPage(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.easeInOutCubicEmphasized);
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white),
                  )
                ],
              )
            ],
          )),
    );
  }

  Column buildBoardingItem(BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Center(
            child: Image.asset('${model.image}'),
          ),
        ),
        Text('${model.title}',
            style: const TextStyle(fontFamily: 'Righteous', fontSize: 25)),
        const SizedBox(
          height: 10,
        ),
        Text('${model.description}', style: defaultTitleTextStyle),
      ],
    );
  }

  void submit() {
    cache.put('onBoarding', true);
    navigateToAndFinish(context, const LoginScreen());
  }
}
