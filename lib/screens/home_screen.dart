import 'dart:ui';
import 'package:custom_background/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> bgImages = List.empty();

  String currBgImagePath = "assets/images/bg1.jpeg";

  Future _initImages() async {
    final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final imageAssetsList = assetManifest
        .listAssets()
        .where((path) => path.startsWith('assets/images/'))
        .toList();
    setState(() {
      bgImages = imageAssetsList;
    });
  }

  @override
  void initState() {
    super.initState();
    _initImages();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final numColumns = width ~/ (400 + 8.0);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(currBgImagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Custom Backgrounds in Flutter",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.transparent,
          ),
          body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: numColumns,
              childAspectRatio: 1.75,
            ),
            itemCount: bgImages.length,
            itemBuilder: (context, index) => ImageCard(
              imagePath: bgImages[index],
              onCardTapped: () => setState(() {
                currBgImagePath = bgImages[index];
              }),
            ),
          ),
        ),
      ),
    );
  }
}
