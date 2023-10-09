import 'package:flutter/material.dart';

class ImageCard extends StatefulWidget {
  final String imagePath;
  final Function() onCardTapped;
  const ImageCard({
    super.key,
    required this.imagePath,
    required this.onCardTapped,
  });

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  double _width = 300.0;
  double _height = 300.0 / 1.75;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: _width,
      height: _height,
      duration: const Duration(seconds: 1),
      curve: Curves.decelerate,
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onCardTapped,
        onHover: (hovering) {
          print(hovering);
          setState(() {
            _width = hovering ? 400.0 : 300.0;
            _height = (hovering ? 400.0 : 300.0) / 1.75;
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 4.0,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(64.0),
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
          ),
          child: ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(64.0),
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
