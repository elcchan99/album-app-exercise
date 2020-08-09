import 'package:album_app/constant.dart';
import 'package:album_app/router.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final String nextRoute;

  const SplashScreen({Key key, this.nextRoute}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class PageData {
  final String text;
  final String image;

  PageData({this.text, this.image});
}

class _SplashScreenState extends State<SplashScreen> {
  int currentIndex = 0;
  final pages = <PageData>[
    PageData(
        text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        image: "https://picsum.photos/id/1005"),
    PageData(
        text:
            "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        image: "https://picsum.photos/id/1003"),
    PageData(
        text:
            "A arcu cursus vitae congue. Ultricies mi quis hendrerit dolor magna eget.",
        image: "https://picsum.photos/id/1010"),
  ];

  void onExit() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: Router.routes[widget.nextRoute]));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int imageWidth = (size.width * .6).round();
    int imageHeight = (imageWidth / 0.8).round();
    return Scaffold(
        backgroundColor: kQuaternaryColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .1),
            child: Column(children: [
              Flexible(
                flex: 2,
                child: Column(children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Album App",
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(color: kSecondaryColor),
                  ),
                  Expanded(
                      child: PageView.builder(
                    itemCount: pages.length,
                    itemBuilder: (context, index) => SplashContent(
                        text: pages[index].text,
                        image: pages[index].image +
                            "/$imageWidth/$imageHeight.jpg"),
                    onPageChanged: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                  )),
                ]),
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              pages.length,
                              (index) => AnimatedContainer(
                                    duration: Duration(milliseconds: 500),
                                    margin: EdgeInsets.only(right: 10),
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                        color: currentIndex == index
                                            ? kFontColor
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                  ))),
                      SizedBox(height: 100),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: kPrimaryColor,
                          child: Text(
                            "Continue",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: onExit,
                        ),
                      )
                    ],
                  ))
            ]),
          ),
        ));
  }
}

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    @required this.text,
    @required this.image,
  }) : super(key: key);

  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        "\n\n$text",
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: kTertiaryColor),
      ),
      Spacer(),
      Image.network(image),
    ]);
  }
}
