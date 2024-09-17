import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kiddo_world_child_app/provider/page_controller_provider.dart';
import 'package:kiddo_world_child_app/provider/sound_provider.dart';
import 'package:provider/provider.dart';

import '../constants/alphabet_list.dart';
import '../model/category_model.dart';
import '../provider/correct_answer_provider.dart';
import 'grid_button.dart';



class CustomPageView extends StatefulWidget {
  final String category;
  final List<CategoryModel> categoryList;

  const CustomPageView(
      {super.key, required this.category, required this.categoryList});

  @override
  State<CustomPageView> createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  final player = AudioPlayer();

  Future<void> delay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  void playAudio() async {
    List<String> audioList = [
      'assets/audios/alphabet/A apple.mp3',
    ];

    for (int i = 0; i < audioList.length; i++) {
      await player.setAsset(audioList[i]);
      await player.play();
      await delay();
    }
  }

  String? selectedChoice;
  List<List<int>> randomIndicesList = [];

  List<Color> colors = [
    Colors.blue,
    Colors.orange,
    Colors.pink,
    Colors.green,
    Colors.deepPurple,
    Colors.yellow
  ];
  List<List<int>> randomColorIndices = [];

  @override
  void initState() {
    for (int i = 0; i < widget.categoryList.length; i++) {
      List<int> indices = List<int>.generate(4, (index) => index);
      indices.shuffle();
      randomIndicesList.add(indices);
    }
    for (int i = 0; i < widget.categoryList.length; i++) {
      List<int> colorIndices = List<int>.generate(4, (index) => index);
      colorIndices.shuffle();
      randomColorIndices.add(colorIndices);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;
    double fontSize = width / 100;
    return Consumer3<PageControllerProvider, CorrectAnswerProvider,
        SoundProvider>(
      builder:
          (context, pageController, correctAnswerProvider, soundProvider, _) {
        return PageView.builder(
          physics: const BouncingScrollPhysics(),
          controller: pageController.pageController,
          itemCount: widget.categoryList.length,
          onPageChanged: (int index) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              for (int i = 0; i < alphabetList[index].voice.length; i++) {
                player.setAsset(
                    "assets/audios/${widget.category.toLowerCase()}/${widget.categoryList[index].voice[i]}");
                player.play();
                delay();
              }
              selectedChoice = '';
              //   setState(() {});
            });
          },
      itemBuilder: (context, index) {
            var alphabet = alphabetList[index];
            Future.delayed(Duration.zero, () {
              if (mounted) {
                correctAnswerProvider.updateCorrectAnswer(
                    widget.categoryList[index].correctOption);
              }
            });
            Future.delayed(Duration.zero, () {
              if (mounted) {
                soundProvider.updateSound(widget.categoryList[index].voice);
              }
            });
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: width * 0.04,
                ),
                if (widget.category != "Shapes")
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(vertical: 10),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.categoryList[index].char,
                              style: TextStyle(
                                  fontFamily: "lemonada",
                                  fontWeight: FontWeight.w700,
                                  color: widget.category == 'Alphabet'
                                      ? Colors.red
                                      : const Color(0xff8C03A2),
                                  fontSize: (height / 100) * 7),
                            ),
                            if (widget.category == 'Alphabet')
                              const Text(
                                'for',
                                style: TextStyle(
                                  fontFamily: "kalam",
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                ),
                              ),
                            if (widget.categoryList[index].isFor != null)
                              Text(
                                widget.categoryList[index].isFor.toString(),
                                style: TextStyle(
                                    fontFamily: widget.category == "Counting"
                                        ? "kaushan"
                                        : 'lemonada',
                                    fontWeight: FontWeight.w900,
                                    color: widget.category == "Counting"
                                        ? const Color(0xff0C0C0C)
                                        : Colors.blueAccent,
                                    fontSize: (height / 100) * 6),
                              ),
                          ],
                        ),
                      ),
                      if (widget.category == "Coloring" ||
                          widget.category == "Animal")
                        Positioned(
                            top: -20,
                            right: -5,
                            child: Container(
                                clipBehavior: Clip.none,
                                child: Image.asset(widget.category == "Animal"
                                    ? "assets/cute-dog.png"
                                    : "assets/shepherd-dog.png",
                                  height: height * 0.13,
                                ))),
                      if (widget.category == "Alphabet")
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Image.asset(
                              'assets/cute-possum.png',
                              height: height * 0.13,
                              // scale: 4,
                            ),
                          ),
                        ),
                      if (widget.category == "Counting")
                        Positioned(
                          left: 5,
                          bottom: 5,
                          child: SizedBox(
                            // width: 100,
                            // height: 100,
                            //   margin: EdgeInsets.all(5),
                            child: Image.asset('assets/cute-squirrel.png',
                              height: height * 0.13,
                            ),
                          ),
                        ),
                    ],
                  ),
                if (widget.category == "Shapes")
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        // height: 220,
                        width: width*0.55,
                    //    margin: EdgeInsets.all(40),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 5,
                                blurRadius: 5,
                                color: Colors.black26)
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Image.asset(
                            "assets/shapes/${widget.categoryList[index].char}_icon.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                          top: -15,
                          left: -60,
                          child: Container(
                              clipBehavior: Clip.none,
                              height: height * 0.13,
                              child: Image.asset("assets/shepherd-dog2.png")))
                    ],
                  ),
                SizedBox(
                  height: width * 0.04,
                ),
                if (widget.category != "Animal")
                  Container(
                    width: double.infinity,
                    height: height * 0.07,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
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
                    child: Center(
                        child: Text(
                      widget.categoryList[index].question,
                      style:  TextStyle(
                          fontFamily: 'kalam',
                          fontSize: (height / 100) * 2.6 ,
                          fontWeight: FontWeight.w900),
                    )),
                  ),
                SizedBox(
                  height: width * 0.04,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GridView.builder(
                 //     physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: width * 0.03,
                        mainAxisSpacing: width * 0.03,
                        childAspectRatio: 1,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, gridIndex) {
                        String choice = widget.categoryList[index]
                            .choices[randomIndicesList[index][gridIndex]];
                        Color color =
                            colors[randomColorIndices[index][gridIndex]];
                        //   widget.categoryList[index].choices;
                        return GridButton(
                          choices: choice,
                          color: color,
                          category: widget.category,
                          selectedChoice: selectedChoice,
                          onSelect: (choice) {
                            setState(() {
                              selectedChoice = choice;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
                if (widget.category == "Animal")
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: height * 0.065,
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
                    child: Center(
                        child: Text(
                      widget.categoryList[index].question,
                      style:  TextStyle(
                          fontFamily: 'kalam',
                          fontSize: (height / 100) * 3,
                          fontWeight: FontWeight.w900),
                    )),
                  ),
                if (widget.category == "Animal") Container()
              ],
            );
          },
        );
      },
    );
  }
}
