import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:evently/providers/app_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/screens/add_event/add_event_screen.dart';
import 'package:evently/screens/home/home_screen.dart';
import 'package:evently/screens/intro/introduction_screen.dart';
import 'package:evently/screens/register/login_screen.dart';
import 'package:evently/screens/register/signup_screen.dart';
import 'core/theme/theming.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseFirestore.instance.enableNetwork();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',

      fallbackLocale: Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => AppProvider()),
        ],

        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    var appProvider = Provider.of<AppProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(393, 841),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        initialRoute: appProvider.firebaseUser != null
            ? HomeScreen.routeName
            : IntroductionScreen.routeName,
        theme: AppTheming.lightTheme,
        darkTheme: AppTheming.darkTheme,
        themeMode: provider.themeMode,
        routes: {
          IntroductionScreen.routeName: (_) => IntroductionScreen(),
          HomeScreen.routeName: (_) => HomeScreen(),
          LoginScreen.routeName: (_) => LoginScreen(),
          SignupScreen.routeName: (_) => SignupScreen(),
          AddEventScreen.routeName: (_) => AddEventScreen(),
        },
      ),
    );
  }
}