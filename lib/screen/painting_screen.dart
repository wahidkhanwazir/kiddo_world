import 'dart:ui' as ui;
import 'dart:ui';

import 'package:floodfill_image/floodfill_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_painter_v2/flutter_painter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:just_audio/just_audio.dart';

class PaintingScreen extends StatefulWidget {
  final String image;

  const PaintingScreen({super.key, required this.image});

  @override
  State<PaintingScreen> createState() => _PaintingScreenState();
}

class _PaintingScreenState extends State<PaintingScreen> {
  Color _fillColor = Colors.amber;
  Color? _previousColor;

  bool showColors = false;

  List<Color> colorsList = [
    Colors.red,
    Colors.redAccent,
    Colors.pink,
    Colors.pinkAccent,
    Colors.purple,
    Colors.purpleAccent,
    Colors.deepPurple,
    Colors.deepPurpleAccent,
    Colors.indigo,
    Colors.indigoAccent,
    Colors.blue,
    Colors.blueAccent,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.cyan,
    Colors.cyanAccent,
    Colors.teal,
    Colors.tealAccent,
    Colors.green,
    Colors.greenAccent,
    Colors.lightGreen,
    Colors.lightGreenAccent,
    Colors.lime,
    Colors.limeAccent,
    Colors.yellow,
    Colors.yellowAccent,
    Colors.amber,
    Colors.amberAccent,
    Colors.orange,
    Colors.orangeAccent,
    Colors.deepOrange,
    Colors.deepOrangeAccent,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
    Colors.white,
  ];

  GlobalKey paintKey = GlobalKey();
  ui.Image? backgroundImage;
  AudioPlayer clickSound = AudioPlayer();

  Future<void> _playClickSound() async {
    await clickSound.setAsset('assets/audios/click.mp3');
    clickSound.play();
  }

  Future<void> screenShotSound() async {
    await clickSound.setAsset('assets/audios/photo-taken.mp3');
    clickSound.play();
  }

  @override
  void initState() {
    initBackground();
    super.initState();
  }

  void initBackground() async {
    final image = await AssetImage(widget.image).image;

    if (mounted) {
      setState(() {
        backgroundImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/home_bg.png"), fit: BoxFit.cover)),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 50, left: 10, right: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: const Color(0xffEEFB9F),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _playClickSound();
                                    Navigator.pop(context);
                                  },
                                  child: SizedBox(
                                    height: 20,
                                    child: Image.asset('assets/back.png'),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                  child: Icon(Icons.delete),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                _playClickSound();
                                if (_previousColor != null) {
                                  _fillColor = _previousColor!;
                                }
                                setState(() {});
                              },
                              child: Container(
                                height: 70,
                                width: 70,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 5,
                                      blurRadius: 5,
                                      color: Colors.red.withOpacity(0.7),
                                      blurStyle: BlurStyle.inner,
                                    )
                                  ],
                                ),
                                child: Image.asset('assets/brush.png'),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _playClickSound();
                                setState(() {
                                  showColors = !showColors;
                                });
                              },
                              child: Container(
                                height: 70,
                                width: 70,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 5,
                                      blurRadius: 5,
                                      color: Colors.black.withOpacity(0.3),
                                      blurStyle: BlurStyle.inner,
                                    )
                                  ],
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: _fillColor,
                                      shape: BoxShape.circle),
                                ),
                                //   child: Image.asset('assets/brush.png'),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _previousColor = _fillColor;
                                _fillColor = Colors.white;
                                setState(() {});
                              },
                              child: Container(
                                height: 70,
                                width: 70,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 5,
                                      blurRadius: 5,
                                      color: Colors.indigo.withOpacity(0.7),
                                      blurStyle: BlurStyle.inner,
                                    )
                                  ],
                                ),
                                child: Image.asset('assets/eraser.png'),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  screenShotSound();
                                  saveImageToGallery();
                                },
                                icon: Icon(Icons.camera_alt)),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 8,
                      child: RepaintBoundary(
                        key: paintKey,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Align(
                            alignment: Alignment.center,
                            child: AspectRatio(
                              aspectRatio: backgroundImage != null
                                  ? backgroundImage!.width /
                                      backgroundImage!.height
                                  : 1.0,
                              child: FloodFillImage(
                                onFloodFillStart: (_, __) {
                                  _playClickSound();
                                },
                                loadingWidget: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                imageProvider: AssetImage(widget.image),
                                fillColor: _fillColor,
                                avoidColor: const [
                                  Colors.black,
                                  Colors.transparent
                                ],
                                tolerance: 20,
                              ),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            if (showColors == true)
              Positioned(
                top: 170, // Adjust the top position as needed
                left: 10, // Adjust the left position as needed
                right: 10, // Adjust the right position as needed
                child: Container(
                  height: height * 0.2,
                  decoration: BoxDecoration(
                      color: const Color(0xffEEFB9F),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GridView.builder(
                        itemCount: colorsList.length,
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              _fillColor = colorsList[index];
                              showColors = false;
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colorsList[index],
                                  shape: BoxShape.circle),
                            ),
                          );
                        }),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  void saveImageToGallery() async {
    final boundary =
        paintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final buffer = byteData!.buffer.asUint8List();
    final result = await ImageGallerySaver.saveImage(buffer);

    if (result['isSuccess']) {
      Fluttertoast.showToast(
          msg: "Image saved!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
        msg: 'Error saving image',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
