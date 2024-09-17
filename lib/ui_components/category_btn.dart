import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.image,
    required this.label,
    this.screen,
  });

  final String image;
  final String label;
  final Widget? screen;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    // double height = size.height;
    double width = size.width;
    return InkWell(
      onTap: () {
        SystemSound.play(SystemSoundType.click);
        if (screen != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => screen!));
        } else {}
      },
      child: Container(
        clipBehavior: Clip.none,
        margin: const EdgeInsets.all(7),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              spreadRadius: 3,
              blurRadius: 3,
              color: Colors.black.withOpacity(0.4))
        ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 4,
              child: Image.asset(
                'assets/$image.png',
                height: 150,
              ),
            ),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                    fontSize: (width / 100) * 6,
                    fontFamily: "kalam",
                    fontWeight: FontWeight.w900),
              ),
            )
          ],
        ),
      ),
    );
  }
}