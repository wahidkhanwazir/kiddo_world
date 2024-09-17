import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiddo_world_child_app/provider/correct_answer_provider.dart';
import 'package:kiddo_world_child_app/provider/page_controller_provider.dart';
import 'package:kiddo_world_child_app/provider/sound_provider.dart';
import 'package:kiddo_world_child_app/screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,overlays: [
    //   SystemUiOverlay.bottom,
    // ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageControllerProvider()),
        ChangeNotifierProvider(create: (context) => CorrectAnswerProvider()),
        ChangeNotifierProvider(create: (context) => SoundProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}


