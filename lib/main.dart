import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list_times/controller/get_docid_controller.dart';
import 'package:flutter_list_times/controller/home_controller.dart';
import 'package:flutter_list_times/controller/theme_controller.dart';
import 'package:flutter_list_times/firebase_options.dart';
import 'package:flutter_list_times/repository/times_repository.dart';
import 'package:flutter_list_times/widgets/checkauth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => TimesRepository()),
        ChangeNotifierProvider(
            create: (contex) => HomeController(contex.read<TimesRepository>())),
        ChangeNotifierProvider(
          create: (context) => GetDocIdController(),
        ),
      ],
      child: Consumer<ThemeController>(
        builder: (context, themeController, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Brasileirão',
            themeMode:
                themeController.isDark ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(color: Colors.deepPurple),
              primaryColor: Colors.green,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData.dark().copyWith(
              appBarTheme: const AppBarTheme(color: Colors.deepPurple),
              primaryColor: Colors.grey,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              brightness: Brightness.dark,
            ),
            home: const CheckAuth(),
/*             routes: {
              '/': (context) => const CheckAuth(),
              '/forgotpasswordpage': (context) => const ForgotPasswordPage(),
            }, */
          );
        },
      ),
    );
  }
}
