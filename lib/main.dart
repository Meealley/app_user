import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kfc/controller/provider/auth_provider.dart';
import 'package:kfc/firebase_options.dart';
import 'package:kfc/view/authscreens/signin_logic_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const KFCApp());
}

class KFCApp extends StatelessWidget {
  const KFCApp({super.key});

  final title = "KFC App";

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, _, __) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => MobileAuthProvier(),
          )
        ],
        child: MaterialApp(
          title: title,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "Manrope",
          ),
          home: const SigninLogiceScreen(),
        ),
      );
    });
  }
}
