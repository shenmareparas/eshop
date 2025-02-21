import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../root_screen.dart';

import 'providers/user_provider.dart';
import 'screens/auth/forgot_password.dart';
import 'screens/auth/login.dart';
import 'screens/auth/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupRemoteConfig();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(const MyApp());
    },
  );
}

Future<void> setupRemoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(hours: 1),
  ));
  await remoteConfig.fetchAndActivate();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: const Color(0xFF0C54BE)),
              useMaterial3: true,
            ),
            home: const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: const Color(0xFF0C54BE)),
              useMaterial3: true,
            ),
            home: Scaffold(
              body: Center(
                child: SelectableText(snapshot.error.toString()),
              ),
            ),
          );
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) {
              return UserProvider();
            }),
          ],
          child: Consumer(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'e-shop',
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: const Color(0xFF0C54BE)),
                  useMaterial3: true,
                ),
                home: const RootScreen(),
                routes: {
                  RootScreen.routeName: (context) => const RootScreen(),
                  RegisterScreen.routName: (context) => const RegisterScreen(),
                  LoginScreen.routeName: (context) => const LoginScreen(),
                  ForgotPasswordScreen.routeName: (context) =>
                      const ForgotPasswordScreen(),
                },
              );
            },
          ),
        );
      },
    );
  }
}
