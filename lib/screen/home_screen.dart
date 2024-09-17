import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kiddo_world_child_app/constants/colors_list.dart';
import 'package:kiddo_world_child_app/constants/shapes_list.dart';
import 'package:kiddo_world_child_app/screen/open_category_screen.dart';
import 'package:kiddo_world_child_app/screen/painting_category.dart';
import '../constants/alphabet_list.dart';
import '../constants/animal_list.dart';
import '../constants/counting_list.dart';
import '../ui_components/category_btn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AudioPlayer clickSound = AudioPlayer();

  Future<void> _playClickSound() async {
    await clickSound.setAsset('assets/audios/click.mp3');
    clickSound.play();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/home_bg.png'), fit: BoxFit.fill)),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  //  height: width * 0.6,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: /* children */ [
                      Positioned(
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                  color: Colors.black26)
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                              child: Text(
                            "Welcome To Kiddo World",
                            style: TextStyle(
                                fontFamily: 'kalam',
                                fontSize: 25,
                                fontWeight: FontWeight.w900),
                          )),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        left: 0,
                        top: -155,
                        child: Container(
                            height: 170,
                            width: 170,
                            clipBehavior: Clip.none,
                            child: Image.asset('assets/cute-hamster.png')),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  width: width * 0.97,
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10),
                  child: GridView(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 30,
                            mainAxisSpacing: 10),
                    children: [
                      CategoryButton(
                        image: "abc",
                        label: "Alphabet",
                        screen: OpenCategory(
                          label: 'Alphabet',
                          categoryList: alphabetList,
                        ),
                      ),
                      CategoryButton(
                        image: "123",
                        label: "Counting",
                        screen: OpenCategory(
                          label: "Counting",
                          categoryList: countingList,
                        ),
                      ),
                      CategoryButton(
                          image: "colors",
                          label: "Coloring",
                          screen: OpenCategory(
                              label: "Coloring", categoryList: colorsList)),
                      CategoryButton(
                          image: "animals",
                          label: "Animal",
                          screen: OpenCategory(
                              label: "Animal", categoryList: animalsList)),
                      CategoryButton(
                        image: "shapes",
                        label: "Shapes",
                        screen: OpenCategory(
                            label: "Shapes", categoryList: shapesList),
                      ),
                      const CategoryButton(
                          image: "painting",
                          label: "Painting",
                          screen: PaintingCategory()),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
