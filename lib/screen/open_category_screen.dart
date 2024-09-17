import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kiddo_world_child_app/provider/sound_provider.dart';
import 'package:kiddo_world_child_app/ui_components/custom_pageview.dart';
import 'package:provider/provider.dart';
import '../model/category_model.dart';


class OpenCategory extends StatefulWidget {
  final String label;
  final List<CategoryModel> categoryList;

  const OpenCategory({super.key, required this.label, required this.categoryList});

  @override
  State<OpenCategory> createState() => _OpenCategoryState();
}
class _OpenCategoryState extends State<OpenCategory> {
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/home_bg.png"), fit: BoxFit.cover)),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: height * 0.065,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () {
                            _playClickSound();
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            'assets/back.png',
                         //   scale: 4,
                          ),
                        ),
                      ),
                      Text(
                        widget.label.toString(),
                        style: const TextStyle(
                            fontFamily: 'kalam',
                        //    fontSize: 25,
                            fontWeight: FontWeight.w900),
                      ),
                      Consumer<SoundProvider>(
                        builder: (context,sounds,_) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: () async {
                                      final player = AudioPlayer();
                                      for (int i = 0; i < sounds.soundList.length; i++) {
                                        await player.setAsset("assets/audios/${widget.label.toLowerCase()}/${sounds.soundList[i]}");
                                        await player.play();
                                        await Future.delayed(const Duration(milliseconds: 500));
                                      }
                              },
                              child: Image.asset(
                                'assets/sound_icon.png',
                             //   scale: 4,
                              ),
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                ),
            
                 Container(
                     height: height * 0.89,
                     width: double.infinity,
                     child: Center(child: CustomPageView(
                       category: widget.label,
                       categoryList: widget.categoryList,
                     ))),
                const SizedBox(
                  height: 10,
                ),
                // Consumer<PageControllerProvider>(
                //     builder: (context, pageController, _) {
                //   return InkWell(
                //     onTap: () {
                //       pageController.nextPage();
                //     },
                //     child: Container(
                //       width: double.infinity,
                //       margin: const EdgeInsets.symmetric(horizontal: 40),
                //       height: height * 0.065,
                //       decoration: BoxDecoration(
                //         boxShadow: const [
                //           BoxShadow(
                //               spreadRadius: 5,
                //               blurRadius: 5,
                //               color: Colors.black26)
                //         ],
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(15),
                //       ),
                //       child:  Center(
                //           child: Text(
                //         'Next ${widget.label}',
                //         style: const TextStyle(
                //             fontFamily: 'kalam',
                //             fontSize: 25,
                //             fontWeight: FontWeight.w900),
                //       )),
                //     ),
                //   );
                // }),
                // const SizedBox(
                //   height: 10,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
