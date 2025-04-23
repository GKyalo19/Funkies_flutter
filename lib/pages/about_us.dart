import 'package:flutter/material.dart';
import 'package:funkies_flutter/router/navigator.dart';
import 'package:funkies_flutter/widgets/text.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Dancers3.png"),
          fit: BoxFit.cover,
          repeat: ImageRepeat.noRepeat,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: const Color.fromARGB(103, 0, 0, 0),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        TextWidget(text: "About Us", textVariant: "boldTitle"),
                        SizedBox(height: 30),
                        TextWidget(
                          text:
                              "Welcome to Funkies 254, your ultimate guide to the most exciting school events, competitions, and festivals across Kenya! Whether it's drama festivals, music extravaganzas, sports tournaments, or academic contests, we bring you real-time updates, schedules, and exclusive highlights from the heart of the action. We created Funkies 254 to bridge the gap between students, fans, and event organizers. No more missing out on your favorite school funkies—our app keeps you in the loop with event details, results, and trending moments, all in one place. Join us as we celebrate talent, culture, and competition in Kenya’s vibrant school scene. Funkies 254—where every moment counts!",
                          textVariant: "light",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(alignment: Alignment.bottomCenter, child: MyNavigator()),
        ],
      ),
    );
  }
}
