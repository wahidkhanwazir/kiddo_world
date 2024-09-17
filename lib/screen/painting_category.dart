import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kiddo_world_child_app/screen/painting_screen.dart';

class PaintingCategory extends StatelessWidget {
  const PaintingCategory({super.key});

  @override
  Widget build(BuildContext context) {
    AudioPlayer clickSound = AudioPlayer();
    Future<void> _playClickSound() async {
      await clickSound.setAsset('assets/audios/click.mp3');
      clickSound.play();
    }
    List<String> sketchesList = [
      for(int i = 1; i <= 28; i++)
        'assets/sketches/sketch$i.png'
    ];
    Size size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/home_bg.png'), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                height: height * 0.065,
                margin:
                const EdgeInsets.only(right: 10, left: 10, top: 60),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        spreadRadius: 5, blurRadius: 5, color: Colors.black26)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        _playClickSound();
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/back.png',
                        scale: 4,
                      ),
                    ),
                    const Text(
                      "Painting",
                      style: TextStyle(
                          fontFamily: 'kalam',
                          fontSize: 25,
                          fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      width: 55,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 11,
                child: GridView.builder(
                    itemCount: sketchesList.length,
                    padding: const EdgeInsets.all(15),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 25),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          _playClickSound();
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => PaintingScreen(image: sketchesList[index])));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                )
                              ]
                          ),
                          child: Image.asset(sketchesList[index].toString()),
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
