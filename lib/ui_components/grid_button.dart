import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import '../provider/correct_answer_provider.dart';
import '../utils/custom_dialogue.dart';

class GridButton extends StatefulWidget {
  final String choices;
  final Color color;
  final String category;
  final String? selectedChoice;
  final Function(String) onSelect;
  const GridButton({super.key, required this.choices, required this.category,  this.selectedChoice, required this.onSelect, required this.color});

  @override
  State<GridButton> createState() => _GridButtonState();
}

class _GridButtonState extends State<GridButton> {
  final player = AudioPlayer();
  bool isCorrect = false;
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
    return Consumer<CorrectAnswerProvider>(
      builder: (context, correctAnswerProvider, _) {
        isCorrect = widget.choices == correctAnswerProvider.correctAnswer;
        return GestureDetector(
          onTap: () async {
            _playClickSound();
            widget.onSelect(widget.choices);
            if (isCorrect) {
              buildShowDialog(context, "Excellent!", "You are true", "Next");
              List<String> soundList = [
                "assets/audios/excellent.mp3",
                "assets/audios/correct.mp3",
              ];
              for (int i = 0; i < soundList.length; i++) {
                await player.setAsset(soundList[i]);
                await player.play();
                await Future.delayed(const Duration(milliseconds: 600));
              }
            } else {
              buildShowDialog(context, "Oops!", "You are wrong", "Try Again");
              await player.setAsset("assets/audios/try_again.mp3");
              await player.play();
            }
          },
          child: Container(
            clipBehavior: Clip.none,
            margin: const EdgeInsets.all(3),
            padding:  EdgeInsets.all(widget.category == "Animal" ? 18 : 15),
            decoration: BoxDecoration(
              shape: widget.category == "Animal" ? BoxShape.circle : BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 3,
                  blurRadius: 3,
                  color: widget.selectedChoice == widget.choices
                      ? (isCorrect ? Colors.green : Colors.red)
                      : Colors.black.withOpacity(0.4),
                ),
              ],
              color: Colors.white,
              borderRadius: widget.category != "Animal" ? BorderRadius.circular(20) : null,
              border: Border.all(
                color: widget.selectedChoice == widget.choices
                    ? (isCorrect ? Colors.green : Colors.red)
                    : Colors.transparent,
              ),
            ),
            child: widget.category != "Shapes" ? Image.asset(
              'assets/${widget.category.toLowerCase()}/${widget.choices}.png',
              height: 150,
            ) : FittedBox(child: Text(widget.choices,style: TextStyle(fontFamily: 'kalamBold',color: widget.color),)),
          ),
        );
      },
    );
  }
}