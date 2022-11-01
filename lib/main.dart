import 'dart:async';

import 'package:devfest_vizag/firebase_options.dart';
import 'package:devfest_vizag/login/login_provider.dart';
import 'package:devfest_vizag/login/registration_form_screen.dart';
import 'package:devfest_vizag/login/user_type.dart';
import 'package:devfest_vizag/nav_host.dart';
import 'package:devfest_vizag/reusable_widgets/loader_screen.dart';
import 'package:devfest_vizag/reusable_widgets/snackbar.dart';
import 'package:devfest_vizag/util/custom_color_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // if (!kIsWeb) {
  //   if (Platform.isAndroid) {
  //     FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
  //   }
  // }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  const keyApplicationId = '6cbvD6LoD77AqYWTvlVCSHIpbP5Nx3w7DvwGcKRv';
  const keyClientKey = 'EgH2l3YIF2MRsyRO4e4jaGtqwlxRe2yrDFLur0Tw';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LoginProvider>(
        create: (context) => LoginProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevFest Vizag 2022',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          //TODO: Update with usergroup
          primarySwatch: createMaterialColor(
            const Color(0xFFFBBC04),
          ),
          fontFamily: "Google Sans"),
      home: const LandingScreen(),
    );
  }
}

class LandingScreen extends StatelessWidget {
  Future<bool> checkIfUserIsRegistered(BuildContext context) async {
    final QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('Registrants'));
    final QueryBuilder<ParseObject> parseQueryVolunteers =
        QueryBuilder<ParseObject>(ParseObject('Volunteers'));

    parseQuery.whereContains(
        "uID", FirebaseAuth.instance.currentUser?.uid ?? "");
    parseQueryVolunteers.whereContains(
        "uID", FirebaseAuth.instance.currentUser?.uid ?? "");
    var responses = await parseQuery.query();
    var responsesVolunteers = await parseQueryVolunteers.query();
    if (responses.success && responses.results != null) {
      if (responses.results!.isNotEmpty) {
        return true;
      } else {
        if (responsesVolunteers.success &&
            responsesVolunteers.results != null) {
          LoginProvider loginProvider =
              Provider.of<LoginProvider>(context, listen: false);
          loginProvider.setUserRole(UserRoles.volunteer);
          if (responsesVolunteers.results!.isNotEmpty) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      }
    } else {
      if (responsesVolunteers.success && responsesVolunteers.results != null) {
        LoginProvider loginProvider =
            Provider.of<LoginProvider>(context, listen: false);
        loginProvider.setUserRole(UserRoles.volunteer);
        if (responsesVolunteers.results!.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }
  }

  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.maybeOf(context);
    Timer(const Duration(milliseconds: 2000), () async {
      if (FirebaseAuth.instance.currentUser == null) {
        navigator?.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => const SplashScreen(),
            ),
            (route) => false);
      } else {
        var isUserRegistered = await checkIfUserIsRegistered(context);
        if (isUserRegistered) {
          Provider.of<LoginProvider>(context, listen: false).showLoader();
        }
        navigator?.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => !isUserRegistered
                  ? const SplashScreen()
                  : const DevFestNavHost(),
            ),
            (route) => false);
      }
    });
    return LayoutBuilder(builder: (context, constraints) {
      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Image.asset("assets/devfest19.png",
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover),
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.4)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: Image.asset("assets/devfest_corner.png"),
                  ),
                  Expanded(
                    child: Padding(
                      padding: constraints.maxWidth <= 600
                          ? const EdgeInsets.all(16.0)
                          : const EdgeInsets.symmetric(
                              horizontal: 86, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Text(
                            "GDG Vizag",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color: Colors.white.withOpacity(0.8)),
                          ),
                          Text(
                            "DevFest 2022",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(color: Colors.white),
                          ),
                          Text(
                            "DevFest is an annual decentralized tech conference hosted by the Google Developer Groups (GDG) community. Through DevFest, you can continue to explore how Google's suite of developer tools can expand the impact of local tech professionals and developers like you around the world. DevFest offers a fantastic platform for developers to connect locally, learn, and build on Google's tools.\nCome, join us to witness this magical massive celebration enthuse you with all fervor!",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, data, _) {
      NavigatorState? navigatorState = Navigator.maybeOf(context);
      Future<void> checkIfUserIsRegistered() async {
        final QueryBuilder<ParseObject> parseQuery =
            QueryBuilder<ParseObject>(ParseObject('Registrants'));
        final QueryBuilder<ParseObject> parseQueryVolunteers =
            QueryBuilder<ParseObject>(ParseObject('Volunteers'));

        parseQuery.whereContains(
            "uID", FirebaseAuth.instance.currentUser?.uid ?? "");
        parseQueryVolunteers.whereContains(
            "uID", FirebaseAuth.instance.currentUser?.uid ?? "");
        var responses = await parseQuery.query();
        var responsesVolunteers = await parseQueryVolunteers.query();
        if (responses.success && responses.results != null) {
          if (responses.results!.isNotEmpty) {
            //Send to navhost
            snackbar(context,
                "Welcome back to the DevFest family, ${FirebaseAuth.instance.currentUser?.displayName ?? "User"}!",
                isError: false);
            data.showLoader();
            navigatorState?.push(MaterialPageRoute(
                builder: (context) => const DevFestNavHost()));
          } else {
            if (responsesVolunteers.success &&
                responsesVolunteers.results != null) {
              if (responsesVolunteers.results!.isNotEmpty) {
                //Send to navhost
                data.setUserRole(UserRoles.volunteer);
                snackbar(context,
                    "Welcome back to the DevFest family, ${FirebaseAuth.instance.currentUser?.displayName ?? "User"}!",
                    isError: false);
                data.showLoader();
                navigatorState?.push(MaterialPageRoute(
                    builder: (context) => const DevFestNavHost()));
              } else {
                snackbar(context,
                    "Welcome to the DevFest family, ${FirebaseAuth.instance.currentUser?.displayName ?? "User"}!",
                    isError: false);
                data.hideLoader();

                navigatorState?.push(
                    MaterialPageRoute(builder: (context) => const UserType()));
              }
            }
          }
        } else {
          if (responsesVolunteers.success &&
              responsesVolunteers.results != null) {
            if (responsesVolunteers.results!.isNotEmpty) {
              //Send to navhost
              data.setUserRole(UserRoles.volunteer);
              snackbar(context,
                  "Welcome back to the DevFest family, ${FirebaseAuth.instance.currentUser?.displayName ?? "User"}!",
                  isError: false);
              data.showLoader();
              navigatorState?.push(MaterialPageRoute(
                  builder: (context) => const DevFestNavHost()));
            } else {
              snackbar(context,
                  "Welcome to the DevFest family, ${FirebaseAuth.instance.currentUser?.displayName ?? "User"}!",
                  isError: false);
              data.hideLoader();

              navigatorState?.push(
                  MaterialPageRoute(builder: (context) => const UserType()));
            }
          } else {
            snackbar(context,
                "Welcome to the DevFest family, ${FirebaseAuth.instance.currentUser?.displayName ?? "User"}!",
                isError: false);
            data.hideLoader();

            navigatorState?.push(
                MaterialPageRoute(builder: (context) => const UserType()));
          }
        }
      }

      Future<void> loginUser() {
        return data.onLoginUser(onSuccessfulLogin: (name) {
          checkIfUserIsRegistered();
        }, onError: (error) {
          snackbar(context, error);
        }, showMessage: (message) {
          snackbar(context, message, isError: false);
        });
      }

      return LayoutBuilder(builder: (context, constraints) {
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                Image.asset("assets/devfest19.png",
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.4)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 300),
                      child: Image.asset("assets/devfest_corner.png"),
                    ),
                    Expanded(
                      child: Padding(
                        padding: constraints.maxWidth <= 600
                            ? const EdgeInsets.all(16.0)
                            : const EdgeInsets.symmetric(
                                horizontal: 86, vertical: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Text(
                              "GDG Vizag",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      color: Colors.white.withOpacity(0.8)),
                            ),
                            Text(
                              "DevFest 2022",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                            Text(
                              "DevFest is an annual decentralized tech conference hosted by the Google Developer Groups (GDG) community. Through DevFest, you can continue to explore how Google's suite of developer tools can expand the impact of local tech professionals and developers like you around the world. DevFest offers a fantastic platform for developers to connect locally, learn, and build on Google's tools.\nCome, join us to witness this magical massive celebration enthuse you with all fervor!",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: () async {
                                data.showLoader();
                                // Trigger the authentication flow
                                final GoogleSignInAccount? googleUser =
                                    await GoogleSignIn().signIn();

                                // Obtain the auth details from the request
                                final GoogleSignInAuthentication? googleAuth =
                                    await googleUser?.authentication;

                                // Create a new credential
                                final credential =
                                    GoogleAuthProvider.credential(
                                  accessToken: googleAuth?.accessToken,
                                  idToken: googleAuth?.idToken,
                                );

                                // Once signed in, return the UserCredential
                                await FirebaseAuth.instance
                                    .signInWithCredential(credential)
                                    .then((value) {
                                  checkIfUserIsRegistered();
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Image(
                                      image:
                                          AssetImage("assets/google_logo.png"),
                                      height: 16.0,
                                      width: 24,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 24, right: 8),
                                      child: Text(
                                        'Register with Google',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // MaterialButton(
                            //   shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(8)),
                            //   color: const Color(0xFFFBBC04),
                            //   onPressed: () {
                            //     //TODO: Change back to UserType
                            //     Navigator.maybeOf(context)?.push(
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //                 const RegistrationFormScreen()));
                            //   },
                            //   child: Row(
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: [
                            //       const Text(
                            //         "Register Now",
                            //       ),
                            //       const SizedBox(
                            //         width: 18,
                            //       ),
                            //       Icon(
                            //         Icons.arrow_forward_rounded,
                            //         size: Theme.of(context)
                            //             .textTheme
                            //             .button
                            //             ?.fontSize,
                            //       )
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Consumer<LoginProvider>(builder: (context, loginProvider, _) {
                  return loginProvider.shouldShowLoader
                      ? const LoaderScreen()
                      : const SizedBox();
                }),
              ],
            ),
          ),
        );
      });
    });
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
