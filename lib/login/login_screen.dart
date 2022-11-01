// // ignore_for_file: use_build_context_synchronously
//
// import 'package:devfest_vizag/login/login_provider.dart';
// import 'package:devfest_vizag/login/registration_screen.dart';
// import 'package:devfest_vizag/login/user_type.dart';
// import 'package:devfest_vizag/nav_host.dart';
// import 'package:devfest_vizag/reusable_widgets/loader_screen.dart';
// import 'package:devfest_vizag/reusable_widgets/snackbar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
// import 'package:pinput/pinput.dart';
// import 'package:provider/provider.dart';
// import 'package:twitter_login/twitter_login.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   GlobalKey<FormState> mobileFormKey = GlobalKey();
//   GlobalKey<FormState> otpFormKey = GlobalKey();
//
//   TextEditingController phoneTextEditController = TextEditingController();
//   TextEditingController otpTextEditController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<LoginProvider>(builder: (context, data, _) {
//      /* NavigatorState? navigatorState = Navigator.maybeOf(context);
//       Future<void> checkIfUserIsRegistered() async {
//         final QueryBuilder<ParseObject> parseQuery =
//             QueryBuilder<ParseObject>(ParseObject('Registrants'));
//         parseQuery.whereContains(
//             "uID", FirebaseAuth.instance.currentUser?.uid ?? "");
//         var responses = await parseQuery.query();
//         if (responses.success && responses.results != null) {
//           if (responses.results!.isNotEmpty) {
//             //Send to navhost
//             snackbar(context,
//                 "Welcome back to the DevFest family, ${FirebaseAuth.instance.currentUser?.displayName ?? "User"}!",
//                 isError: false);
//             data.showLoader();
//             navigatorState?.push(MaterialPageRoute(
//                 builder: (context) => const DevFestNavHost()));
//           } else {
//             snackbar(context,
//                 "Welcome to the DevFest family, ${FirebaseAuth.instance.currentUser?.displayName ?? "User"}!",
//                 isError: false);
//             data.hideLoader();
//
//             navigatorState?.push(MaterialPageRoute(
//                 builder: (context) => const UserType()));
//           }
//         } else {
//           snackbar(context,
//               "Welcome to the DevFest family, ${FirebaseAuth.instance.currentUser?.displayName ?? "User"}!",
//               isError: false);
//           data.hideLoader();
//
//           navigatorState?.push(MaterialPageRoute(
//               builder: (context) => const UserType()));
//         }
//       }
//
//       Future<void> loginUser() {
//         return data.onLoginUser(mobileFormKey, phoneTextEditController,
//             onSuccessfulLogin: (name) {
//           checkIfUserIsRegistered();
//         }, onError: (error) {
//           snackbar(context, error);
//         }, showMessage: (message) {
//           snackbar(context, message, isError: false);
//         }, navigateToOTPScreen: (onValidateOTP) {
//           showModalBottomSheet(
//               context: context,
//               backgroundColor: Colors.transparent,
//               builder: (context) {
//                 return Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: const BoxDecoration(
//                       color: Color(0xFFFFFFFF),
//                       borderRadius:
//                           BorderRadius.vertical(top: Radius.circular(16))),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(
//                         height: 24,
//                       ),
//                       Text(
//                         "OTP Verification",
//                         style: Theme.of(context).textTheme.titleLarge,
//                       ),
//                       Text(
//                           "Enter the one-time password you've recieved on your mobile number +91 ${phoneTextEditController.text.substring(0, 5)} ${phoneTextEditController.text.substring(5, 10)}"),
//                       const SizedBox(
//                         height: 24,
//                       ),
//                       Form(
//                         key: otpFormKey,
//                         child: Pinput(
//                           length: 6,
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           defaultPinTheme: PinTheme(
//                             width: 48,
//                             height: 60,
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                   width: 2, color: Colors.grey.shade600),
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(8)),
//                             ),
//                           ),
//                           controller: otpTextEditController,
//                           forceErrorState: true,
//                           pinputAutovalidateMode:
//                               PinputAutovalidateMode.onSubmit,
//                           onChanged: (pin) {
//                             setState(() {});
//                           },
//                           onSubmitted: (pin) {
//                             var isFormReadyForSubmission =
//                                 otpFormKey.currentState?.validate() ?? false;
//                             if (isFormReadyForSubmission) {
//                               onValidateOTP(
//                                   otpTextEditController.text.toString());
//                             }
//                           },
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 36,
//                       ),
//                       MaterialButton(
//                         onPressed: () {
//                           var isFormReadyForSubmission =
//                               otpFormKey.currentState?.validate() ?? false;
//                           if (isFormReadyForSubmission) {
//                             onValidateOTP(
//                                 otpTextEditController.text.toString());
//                           }
//                         },
//                         height: 64,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16)),
//                         color: otpTextEditController.text.length == 6
//                             ? Theme.of(context).primaryColor
//                             : Colors.grey.shade400,
//                         textColor: Colors.white,
//                         child: Row(
//                           children: const [
//                             Text("Verify OTP"),
//                             Spacer(),
//                             Icon(Icons.arrow_forward),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 16,
//                       ),
//                     ],
//                   ),
//                 );
//               });
//         });
//       }*/
//
//       return Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Stack(
//           children: [
//             Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Image.asset("assets/top_branding.png"),
//               const SizedBox(
//                 height: 48,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 32),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       "Login",
//                       style: Theme.of(context).textTheme.titleLarge,
//                     ),
//                     const Text("Please enter your mobile number to continue"
//                         // "Lorem ipsum dolor sit amet, connectsor adipsicing alit.",
//                         ),
//                     const SizedBox(
//                       height: 24,
//                     ),
//                     Form(
//                       key: mobileFormKey,
//                       child: TextFormField(
//                         textInputAction: TextInputAction.done,
//                         onFieldSubmitted: (_) {
//                           data.showLoader();
//                           loginUser();
//                         },
//                         validator: (value) {
//                           if (value?.length != 10) {
//                             snackbar(
//                                 context, "Please enter a valid mobile number");
//                             return " ";
//                           } else {
//                             return null;
//                           }
//                         },
//                         style: Theme.of(context)
//                             .textTheme
//                             .subtitle1
//                             ?.copyWith(fontWeight: FontWeight.w500),
//                         keyboardType: TextInputType.phone,
//                         maxLength: 10,
//                         controller: phoneTextEditController,
//                         decoration: InputDecoration(
//                             filled: true,
//                             prefixText: "+91 ",
//                             hintText: 'Phone number',
//                             prefixIcon: Icon(
//                               Icons.phone_rounded,
//                               size: Theme.of(context)
//                                   .textTheme
//                                   .subtitle1
//                                   ?.fontSize,
//                             )),
//                       ),
//                     ),
//                     MaterialButton(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       onPressed: () {
//                         data.showLoader();
//                         loginUser();
//                       },
//                       color: const Color(0xFFFBBC04),
//                       child: const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Text(
//                           "Login",
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     const Center(child: Text("or, Connect with ")),
//                     const SizedBox(
//                       height: 16,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors.white,
//                             onPrimary: Colors.black,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                           ),
//                           onPressed: () async {
//                             data.showLoader();
//                             // Trigger the authentication flow
//                             final GoogleSignInAccount? googleUser =
//                                 await GoogleSignIn().signIn();
//
//                             // Obtain the auth details from the request
//                             final GoogleSignInAuthentication? googleAuth =
//                                 await googleUser?.authentication;
//
//                             // Create a new credential
//                             final credential = GoogleAuthProvider.credential(
//                               accessToken: googleAuth?.accessToken,
//                               idToken: googleAuth?.idToken,
//                             );
//
//                             // Once signed in, return the UserCredential
//                             await FirebaseAuth.instance
//                                 .signInWithCredential(credential)
//                                 .then((value) {
//                               checkIfUserIsRegistered();
//                             });
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: const [
//                                 Image(
//                                   image: AssetImage("assets/google_logo.png"),
//                                   height: 16.0,
//                                   width: 24,
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(left: 24, right: 8),
//                                   child: Text(
//                                     'Google',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.black54,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             primary: const Color(0xFF1d9bef),
//                             onPrimary: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                           ),
//                           onPressed: () async {
//                             data.showLoader();
//                             final twitterLogin = TwitterLogin(
//                               apiKey: "pltJWpeF6OcMsp5YwzuymEjzu",
//                               apiSecretKey:
//                                   "Si6D1KBauUxdlF7xKFB699opHfV5ix62DqMWYeJps0jwKNisvX",
//                               redirectURI: "twitter-firebase-auth://",
//                             );
//                             final authResult = await twitterLogin.login();
//
//                             switch (authResult.status) {
//                               case TwitterLoginStatus.loggedIn:
//                                 final AuthCredential twitterAuthCredential =
//                                     TwitterAuthProvider.credential(
//                                         accessToken: authResult.authToken!,
//                                         secret: authResult.authTokenSecret!);
//
//                                 final userCredential = await FirebaseAuth
//                                     .instance
//                                     .signInWithCredential(twitterAuthCredential)
//                                     .then((value) {
//                                   checkIfUserIsRegistered();
//                                 });
//                                 break;
//                               case TwitterLoginStatus.cancelledByUser:
//                                 //Auth successful
//                                 break;
//                               case TwitterLoginStatus.error:
//                                 //Auth unsuccessful
//                                 break;
//                               default:
//                                 //Do nothing
//                                 break;
//                             }
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: const [
//                                 Image(
//                                   image: AssetImage("assets/twitter.png"),
//                                   height: 16.0,
//                                   width: 24,
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(left: 24, right: 8),
//                                   child: Text(
//                                     'Twitter',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               const Spacer(),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 32),
//                 child: Image.asset("assets/bottom_branding.png"),
//               ),
//             ]),
//             Consumer<LoginProvider>(builder: (context, loginProvider, _) {
//               return loginProvider.shouldShowLoader
//                   ? const LoaderScreen()
//                   : const SizedBox();
//             })
//           ],
//         ),
//       );
//     });
//   }
// }
