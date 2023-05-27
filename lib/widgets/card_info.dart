import 'package:flutter/material.dart';

class CardInfoData {
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Widget? bacground;

  const CardInfoData(
      {required this.title,
      required this.subtitle,
      required this.image,
      required this.backgroundColor,
      required this.titleColor,
      required this.subtitleColor,
      required this.bacground});
}

class CardInfo extends StatelessWidget {
  const CardInfo({required this.data, super.key});

  final CardInfoData data;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(top: 130, left: 80, child: data.bacground!),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 40,
          ),
          child: Column(
            children: [
              const Spacer(flex: 3),
              Flexible(flex: 20, child: Image(image: data.image)),
              const Spacer(flex: 2),
              Text(
                data.title.toUpperCase(),
                style: TextStyle(
                  color: data.titleColor,
                  fontFamily: 'Roundman',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                maxLines: 1,
              ),
              const Spacer(flex: 1),
              Text(
                data.subtitle,
                style: TextStyle(
                  color: data.subtitleColor,
                  fontFamily: 'Roundman',
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              const Spacer(flex: 10),
            ],
          ),
        ),
      ],
    );
  }
}
