import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testthree/custom_data.dart';

class AnimatedCarousel extends StatefulWidget {
  const AnimatedCarousel({super.key});

  @override
  State<AnimatedCarousel> createState() => _AnimatedCarouselState();
}

class _AnimatedCarouselState extends State<AnimatedCarousel> {
  PageController controller = PageController();
  final List<CardItem> _list = [
    CardItem("Yoga Events", "You don't have to be a Yoga teacher to complete a", "assets/bgOne.png"),
    CardItem("Dabur Walkathon Event", "You don't have to be a runner to complete a Half Marathon.", "assets/bgTwo.png"),
    CardItem("Yoga Events", "You don't have to be a Yoga teacher to complete a", "assets/bgOne.png"),
  ];

  final List<Color> _listColors = [
    Colors.deepOrange,
    Colors.amber,
    Colors.blueAccent,
    Colors.red,
  ];
  int _curr = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: 78,
              margin: const EdgeInsets.all(30),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: _listColors[_curr],
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(_list[_curr].bgImage),
                      fit: BoxFit.fill)),
              child: Stack(
                children: [
                  PageView(
                    scrollDirection: Axis.horizontal,
                    controller: controller,
                    onPageChanged: (num) {
                      setState(() {
                        _curr = num;
                      });
                    },
                    children: List.generate(
                        _list.length,
                        (index) => Pages(
                              item: _list[index],
                            )),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 13,
                      width: double.maxFinite,
                      child: Center(
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: _list.length,
                            itemBuilder: (ctx, index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: _curr == index ? 30 : 15,
                            margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                            decoration: BoxDecoration(
                              color: _curr == index ? _listColors[_curr] : Colors.white,
                              borderRadius: BorderRadius.circular(90),
                            ),
                          );
                        }),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Pages extends StatelessWidget {
  final CardItem item;

  const Pages({super.key, required this.item,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              item.title ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
              item.subTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(90),
              ),
              child: const Text(
                "View Details",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
              ),
            ),
          ]),
    );
  }
}
