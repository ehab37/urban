import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/providers/authProvider.dart';
import 'package:urban/providers/fireProvider.dart';
import 'package:urban/routes.dart';
import 'package:urban/screens/home_screen.dart';
import 'package:urban/screens/sign/signing_screen.dart';
import 'providers/lang_provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  if (defaultTargetPlatform == TargetPlatform.android) {}
  Auth auth = Auth();
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool? login = pref.getBool('login');
  String screen;

  if (login == null || login == false) {
    screen = SigningScreen.route;
    FlutterNativeSplash.remove();
  } else {
    auth.email = pref.getString('email')!;
    auth.password = pref.getString('password')!;

    if (await auth.logIn()) {
      screen = Home.route;
    } else {
      screen = SigningScreen.route;
    }
  }

  FlutterNativeSplash.remove();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FireProvider(),
        ),
      ],
      child: MyApp(
        screen: screen,
      )));
}

class MyApp extends StatefulWidget {
  final String screen;

  const MyApp({Key? key, required this.screen}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool done = false;

  func() async {
    var fire = Provider.of<FireProvider>(context, listen: false);
    if (await fire.getMyUserInfo(context: context)) {
      FlutterNativeSplash.remove();
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    func();
  }

  @override
  Widget build(BuildContext context) {
    // func();

    return ChangeNotifierProvider(
      create: (_) => LangProvider(),
      child: Consumer<LangProvider>(
          builder: (context, LangProvider lanNoty, child) {
        return MaterialApp(
          color: Colors.white,

          debugShowCheckedModeBanner: false,
          routes: routes,

          initialRoute: widget.screen,
          //FirstScreen.route
          //LoginScreen.route
          // Home.route

          localizationsDelegates: const [
            AppLocale.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],

          supportedLocales: const [
            Locale('en', ''),
            Locale('ar', ''),
          ],
          localeResolutionCallback: (currentLang, supportLang) {
            if (currentLang == null) {
              return supportLang.first;
            } else {
              return currentLang;
            }
          },
          locale: lanNoty.isEn ? const Locale('en', '') : const Locale('ar', '')
          //locale
          ,

          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
                backgroundColor:
                    // Colors.cyan
                    Colors.orangeAccent
                //Colors.tealAccent
                ,
                elevation: 0
                // actionsIconTheme: IconThemeData(color: Colors.black.withOpacity(.7),),
                // iconTheme: IconThemeData(color: Colors.black.withOpacity(.7),),
                // toolbarTextStyle:TextStyle() ,
                //titleTextStyle: TextStyle(color: Colors.black.withOpacity(.7)),
                // shadowColor: Colors.black,
                // centerTitle: true,//reverse colors???? contact photo
                ),

            textTheme: TextTheme(
              bodySmall: const TextStyle(
                color: Colors.black,
              ),
              titleMedium: TextStyle(color: Colors.black.withOpacity(.7)),
            ),

            primaryColor: Colors.white,

            canvasColor: Colors.black,
            cardColor: Colors.black,
            //  floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.grey.shade600),
            //shadowColor: Colors.black,

            // iconTheme: IconThemeData(color:  Colors.black.withOpacity(.7),),

            //dialogBackgroundColor: Colors.white
          ),

          themeMode: ThemeMode.light,
        );
      }),
    );
  }
}

/*

    ChangeNotifierProvider(
                                create: (_) =>LangProvider() ,
                                child:  Consumer<LangProvider>(
                                  builder: (context,LangProvider lanNoty,child) {
                                    return Center() ;
                                  }
                                ),
                              ),
*/
//lanNoty.isEn?e.en!:e.ar!
