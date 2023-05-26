import 'package:concentric_transition/page_view.dart';
import 'package:flutter/material.dart';
import 'package:banana_fashion/widgets/card_info.dart';
import 'package:lottie/lottie.dart';

class ConcentricTrasition extends StatelessWidget {
  ConcentricTrasition({super.key});
  final data = [
    CardInfoData(
        title: "Tienda online!!!",
        subtitle: "Compra ropa online en todo Mexíco y descubre tu nuevo look!",
        image: AssetImage("assets/logo_transparent.png"),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        titleColor: Color.fromARGB(255, 46, 46, 46),
        subtitleColor: Color.fromARGB(255, 46, 46, 46),
        bacground: LottieBuilder.asset("assets/info_animation.json")),
    CardInfoData(
        title: "Encuentra tu estilo!!!",
        subtitle:
            "Ropa de varias de marcas nacionales e internacionales y marca propia",
        image: AssetImage("assets/chavos.png"),
        backgroundColor: Color.fromARGB(255, 255, 220, 63),
        titleColor: Color.fromARGB(255, 46, 46, 46),
        subtitleColor: Color.fromARGB(255, 46, 46, 46),
        bacground: LottieBuilder.asset("assets/info_animation2.json"))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (index) {
          return CardInfo(data: data[index]);
        },
        onFinish: () {
          Navigator.pushNamed(context, '/home');
        },
      ),
    );
  }
}
