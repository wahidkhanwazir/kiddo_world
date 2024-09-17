import 'package:flutter/material.dart';
import 'package:kiddo_world_child_app/provider/page_controller_provider.dart';
import 'package:provider/provider.dart';


Future<dynamic> buildShowDialog(
    BuildContext context, String title, String content, String btn) {
  return showDialog(
      context: context,
      builder: (context) {
        var pageProvider = Provider.of<PageControllerProvider>(context);
        return Dialog(
          backgroundColor: Colors.white,
          child: Container(
           height: 250,
            width: 180,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                    left: 0,
                    right: 0,
                    top: -100,
                    child: Image.asset(
                      'assets/cute-squirrel.png',
                      scale: 2,
                    )),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 10,
                  // top: 100,
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontFamily: 'kalam', fontSize: 25),
                      ),
                      Text(
                        content,
                        style: TextStyle(fontFamily: 'kalam'),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: btn == "Try Again"
                                  ? Colors.red
                                  : Colors.blueAccent),
                          onPressed: () {
                            if (btn == "Try Again") {
                              Navigator.pop(context);
                            } else {
                              Navigator.pop(context);
                              pageProvider.nextPage();
                            }
                          },
                          child: SizedBox(
                            width: 150,
                            child: Center(
                              child: Text(
                                btn,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
