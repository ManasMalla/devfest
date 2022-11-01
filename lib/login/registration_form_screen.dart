import 'dart:convert';

import 'package:devfest_vizag/login/form_fields/radio_form.dart';
import 'package:devfest_vizag/login/form_fields/textfield_form.dart';
import 'package:devfest_vizag/login/login_provider.dart';
import 'package:devfest_vizag/login/user_type.dart';
import 'package:devfest_vizag/my_flutter_app_icons.dart';
import 'package:devfest_vizag/reusable_widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:provider/provider.dart';

import '../nav_host.dart';
import '../reusable_widgets/loader_screen.dart';

class RegistrationFormScreen extends StatefulWidget {
  const RegistrationFormScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationFormScreen> createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  GlobalKey<FormState> registrationForm = GlobalKey();

  TextEditingController nameTextEditingController = TextEditingController(
      text: FirebaseAuth.instance.currentUser?.displayName);
  TextEditingController emailTextEditingController =
      TextEditingController(text: FirebaseAuth.instance.currentUser?.email);
  TextEditingController phoneTextEditingController = TextEditingController(
      text: FirebaseAuth.instance.currentUser?.phoneNumber);
  String gender = "";
  TextEditingController cityTextEditingController = TextEditingController();
  String iAmA = "";
  TextEditingController organizationTextEditingController =
      TextEditingController();
  String pastGDGEvents = "";
  TextEditingController whyAttendDevFest = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController githubController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  var tracks = ["Android", "Flutter", "ML", "Cloud", "Other"];
  var trackBools = [false, false, false, false, false];
  var volunteerRolesBools = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  var volunteerRoles = [
    "Logistics",
    "Email",
    "Registration",
    "Social Media",
    "Content",
    "Flutter",
    "Android ",
    "Web",
    "Cloud",
    "ML",
    "Community Outreach"
  ];
  TextEditingController otherTracksController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<LoginProvider>(builder: (context, loginProvider, _) {
          NavigatorState navigatorState = Navigator.of(context);
          return Scaffold(
            body: LayoutBuilder(builder: (context, constraints) {
              return Row(
                children: [
                  constraints.maxWidth <= 600
                      ? const SizedBox()
                      : Image.asset("assets/left_branding.png"),
                  SizedBox(
                    width: constraints.maxWidth <= 600 ? 0 : 16,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            constraints.maxWidth <= 600
                                ? Image.asset("assets/top_branding.png")
                                : const SizedBox(),
                            SizedBox(
                              height: constraints.maxWidth <= 600 ? 48 : 48,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Register",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text(
                                      "Excited to attend this year's developers' celebration? Register now to join the party!",
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Form(
                                      key: registrationForm,
                                      child: Column(
                                        children: [
                                          TextFieldForm(
                                            label: 'Name',
                                            icon: Icons.person_rounded,
                                            keyboardType: TextInputType.name,
                                            textEditingController:
                                                nameTextEditingController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Please enter your full name";
                                              }
                                              return null;
                                            },
                                          ),
                                          TextFieldForm(
                                            label: 'Phone Number',
                                            icon: Icons.phone_rounded,
                                            textEditingController:
                                                phoneTextEditingController,
                                            keyboardType: TextInputType.phone,
                                            validator: (value) {
                                              if (value?.length != 10) {
                                                return "Please enter a valid mobile number";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                          TextFieldForm(
                                            label: 'Email Address',
                                            icon: Icons.email_rounded,
                                            textEditingController:
                                                emailTextEditingController,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  !value.contains("@") ||
                                                  !value.contains(".")) {
                                                return "Please enter a valid email address";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                          RadioForm<String>(
                                              label: "Gender",
                                              icon: Icons.face_rounded,
                                              data: gender,
                                              onSelected: (_) {
                                                setState(() {
                                                  gender = _;
                                                });
                                              },
                                              options: const [
                                                "Male",
                                                "Female",
                                                "Prefer not to say"
                                              ]),
                                          TextFieldForm(
                                            label: "Where are you from?",
                                            icon: Icons.location_on_rounded,
                                            textEditingController:
                                                cityTextEditingController,
                                            validator: (_) {
                                              if (_ == null || _.isEmpty) {
                                                return "Please enter a valid city";
                                              } else {
                                                return null;
                                              }
                                            },
                                            keyboardType:
                                                TextInputType.streetAddress,
                                          ),
                                          RadioForm<String>(
                                              label: "Career Status",
                                              icon: Icons.work_rounded,
                                              data: iAmA,
                                              onSelected: (_) {
                                                setState(() {
                                                  iAmA = _;
                                                });
                                              },
                                              options: const [
                                                "Student",
                                                "Intern",
                                                "Freelancer",
                                                "Working Professional",
                                              ]),
                                          TextFieldForm(
                                            label: "Organization",
                                            icon: Icons.apartment_rounded,
                                            textEditingController:
                                                organizationTextEditingController,
                                            validator: (_) {
                                              if (_ == null || _.isEmpty) {
                                                return "Please enter a valid organization name";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                          TextFieldForm(
                                            label: "Twitter handle",
                                            icon: MyFlutterApp.twitter,
                                            textEditingController:
                                                twitterController,
                                            validator: (_) {
                                              return null;
                                            },
                                            isSocial: true,
                                          ),
                                          TextFieldForm(
                                            label: "Instagram handle",
                                            icon: MyFlutterApp.instagram,
                                            textEditingController:
                                                instagramController,
                                            isSocial: true,
                                            validator: (_) {
                                              return null;
                                            },
                                          ),
                                          TextFieldForm(
                                            label: "LinkedIn handle",
                                            icon: MyFlutterApp.linkedin_squared,
                                            textEditingController:
                                                linkedinController,
                                            isSocial: true,
                                            validator: (_) {
                                              return null;
                                            },
                                          ),
                                          TextFieldForm(
                                            maxLines: null,
                                            label: "Website",
                                            icon: Icons.web_rounded,
                                            textEditingController:
                                                websiteController,
                                            validator: (_) {
                                              return null;
                                            },
                                          ),
                                          RadioForm<String>(
                                              label:
                                                  "Have you attended any of our past events?",
                                              icon: Icons.history_rounded,
                                              data: pastGDGEvents,
                                              onSelected: (_) {
                                                setState(() {
                                                  pastGDGEvents = _;
                                                });
                                              },
                                              options: const [
                                                "Yes 🤩",
                                                "No 😔",
                                                "Registered, but not shortlisted 😭",
                                              ]),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.celebration_rounded,
                                                size: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.fontSize,
                                                color: Colors.black45,
                                              ),
                                              const SizedBox(
                                                width: 12,
                                              ),
                                              Text(
                                                "Why do you want to attend DevFest 2022?",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          TextFieldForm(
                                            maxLines: null,
                                            label:
                                                "I want to attend DevFest because",
                                            icon: Icons.celebration_rounded,
                                            textEditingController:
                                                whyAttendDevFest,
                                            validator: (_) {
                                              if (_ == null || _.isEmpty) {
                                                return "Please enter a valid response";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                          loginProvider.userRole ==
                                                  UserRoles.attendee
                                              ? Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .interests_rounded,
                                                          size:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium
                                                                  ?.fontSize,
                                                          color: Colors.black45,
                                                        ),
                                                        const SizedBox(
                                                          width: 12,
                                                        ),
                                                        Text(
                                                          "Select the Google tech stacks that you're interested in?",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleMedium
                                                              ?.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    ListView.separated(
                                                      shrinkWrap: true,
                                                      primary: false,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Checkbox(
                                                                    value: trackBools[
                                                                        index],
                                                                    onChanged:
                                                                        (_) {
                                                                      setState(
                                                                          () {
                                                                        trackBools[index] =
                                                                            _ ??
                                                                                false;
                                                                      });
                                                                    }),
                                                                Expanded(
                                                                    child: Text(
                                                                        tracks[
                                                                            index])),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: trackBools[
                                                                          index] &&
                                                                      index == 4
                                                                  ? 8
                                                                  : 0,
                                                            ),
                                                            trackBools[index] &&
                                                                    index == 4
                                                                ? TextFieldForm(
                                                                    label:
                                                                        "What would you love to learn @ DevFest",
                                                                    icon: Icons
                                                                        .local_library_rounded,
                                                                    textEditingController:
                                                                        otherTracksController,
                                                                    validator:
                                                                        (_) {
                                                                      if (_ ==
                                                                              null ||
                                                                          _.isEmpty) {
                                                                        return "Please enter a valid response";
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                    maxLines:
                                                                        null,
                                                                  )
                                                                : const SizedBox(),
                                                            // trackBools[index] && index < 2
                                                            //     ? Column(
                                                            //         mainAxisSize:
                                                            //             MainAxisSize.min,
                                                            //         children: [
                                                            //           TextFieldForm(
                                                            //             label:
                                                            //                 "Please share your experience with ${index == 0 ? "Android" : "Flutter"} development",
                                                            //             icon: index == 0
                                                            //                 ? Icons
                                                            //                     .android_rounded
                                                            //                 : Icons
                                                            //                     .flutter_dash_rounded,
                                                            //             textEditingController:
                                                            //                 flutterQuestionController,
                                                            //             validator: (_) {
                                                            //               return null;
                                                            //             },
                                                            //             maxLines: null,
                                                            //           ),
                                                            //           TextFieldForm(
                                                            //             label:
                                                            //                 "Please share about your ${index == 0 ? "Android" : "Flutter"} projects",
                                                            //             icon: index == 0
                                                            //                 ? Icons
                                                            //                     .android_rounded
                                                            //                 : Icons
                                                            //                     .flutter_dash_rounded,
                                                            //             textEditingController:
                                                            //                 flutterQuestionController,
                                                            //             validator: (_) {
                                                            //               return null;
                                                            //             },
                                                            //             maxLines: null,
                                                            //           ),
                                                            //           Text(
                                                            //             "Sundar wants to finish his app before the DevFest keynote, however his code goes out of screen bounds. So, here's your golden opportunity to help him shorten the code using getters and the shorthand \"fat arrow\" syntax.",
                                                            //             style: Theme.of(context)
                                                            //                 .textTheme
                                                            //                 .titleMedium
                                                            //                 ?.copyWith(
                                                            //                     fontWeight:
                                                            //                         FontWeight
                                                            //                             .w500),
                                                            //           ),
                                                            //           const SizedBox(
                                                            //             height: 8,
                                                            //           ),
                                                            //           Container(
                                                            //             padding:
                                                            //                 const EdgeInsets
                                                            //                         .symmetric(
                                                            //                     horizontal: 32,
                                                            //                     vertical: 16),
                                                            //             decoration: BoxDecoration(
                                                            //                 borderRadius:
                                                            //                     BorderRadius
                                                            //                         .circular(
                                                            //                             12),
                                                            //                 color: Theme.of(
                                                            //                         context)
                                                            //                     .primaryColor
                                                            //                     .withOpacity(
                                                            //                         0.1)),
                                                            //             child: Text(
                                                            //               "class Keynote  {\n   String organizer;\n   String message;\n\n   Keynote(this.organizer, this.message)\n\n   String makeAnnouncement(){\n      return organizer + message;\n   }\n}",
                                                            //               style: Theme.of(
                                                            //                       context)
                                                            //                   .textTheme
                                                            //                   .titleMedium
                                                            //                   ?.copyWith(
                                                            //                       fontWeight:
                                                            //                           FontWeight
                                                            //                               .w500),
                                                            //             ),
                                                            //           ),
                                                            //           const SizedBox(
                                                            //             height: 16,
                                                            //           ),
                                                            //           TextFieldForm(
                                                            //             label: "Your code",
                                                            //             icon: index == 0
                                                            //                 ? Icons
                                                            //                     .android_rounded
                                                            //                 : Icons
                                                            //                     .flutter_dash_rounded,
                                                            //             textEditingController:
                                                            //                 flutterQuestionController,
                                                            //             validator: (_) {
                                                            //               return null;
                                                            //             },
                                                            //             maxLines: null,
                                                            //           ),
                                                            //         ],
                                                            //       )
                                                            //     : const SizedBox()
                                                          ],
                                                        );
                                                      },
                                                      itemCount: tracks.length,
                                                      separatorBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return SizedBox(
                                                            height: 8);
                                                      },
                                                    ),
                                                  ],
                                                )
                                              : Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .interests_rounded,
                                                          size:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium
                                                                  ?.fontSize,
                                                          color: Colors.black45,
                                                        ),
                                                        const SizedBox(
                                                          width: 12,
                                                        ),
                                                        Text(
                                                          "Select the team(s) that you are volunteering for?",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleMedium
                                                              ?.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    ListView.separated(
                                                      shrinkWrap: true,
                                                      primary: false,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Checkbox(
                                                                    value: volunteerRolesBools[
                                                                        index],
                                                                    onChanged:
                                                                        (_) {
                                                                      setState(
                                                                          () {
                                                                        volunteerRolesBools[index] =
                                                                            _ ??
                                                                                false;
                                                                      });
                                                                    }),
                                                                Expanded(
                                                                    child: Text(
                                                                        volunteerRoles[
                                                                            index])),
                                                              ],
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                      itemCount: 11,
                                                      separatorBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return SizedBox(
                                                            height: 8);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    MaterialButton(
                                      minWidth: double.infinity,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      onPressed: () async {
                                        if (!loginProvider.shouldShowLoader) {
                                          //Register the user
                                          loginProvider.showLoader();
                                          var isFormFilled = registrationForm
                                                  .currentState
                                                  ?.validate() ??
                                              true;
                                          // snackbar(context, isFormFilled);
                                          isFormFilled = isFormFilled &&
                                              gender.isNotEmpty &&
                                              iAmA.isNotEmpty &&
                                              pastGDGEvents.isNotEmpty;

                                          if (loginProvider.userRole ==
                                              UserRoles.attendee) {
                                            isFormFilled = isFormFilled &&
                                                trackBools
                                                    .where((element) => element)
                                                    .isNotEmpty;
                                          } else if (loginProvider.userRole ==
                                              UserRoles.volunteer) {
                                            isFormFilled = isFormFilled &&
                                                volunteerRolesBools
                                                    .where((element) => element)
                                                    .isNotEmpty;
                                          }

                                          if (isFormFilled) {
                                            //Register the user
                                            var body = {
                                              "name": nameTextEditingController
                                                  .text,
                                              "phoneNumber":
                                                  phoneTextEditingController
                                                      .text,
                                              "emailAddress":
                                                  emailTextEditingController
                                                      .text,
                                              "gender": gender,
                                              "city": cityTextEditingController
                                                  .text,
                                              "careerStatus": iAmA,
                                              "organization":
                                                  organizationTextEditingController
                                                      .text,
                                              "twitter": twitterController.text,
                                              "instagram":
                                                  instagramController.text,
                                              "linkedIn":
                                                  linkedinController.text,
                                              "website": websiteController.text,
                                              "attendPastEvents": pastGDGEvents,
                                              "whyAttendDevFest":
                                                  whyAttendDevFest.text,
                                            };
                                            if (loginProvider.userRole ==
                                                UserRoles.attendee) {
                                              body.addAll({
                                                "interestedInAndroid":
                                                    trackBools[0].toString(),
                                                "interestedInFlutter":
                                                    trackBools[1].toString(),
                                                "interestedInML":
                                                    trackBools[2].toString(),
                                                "interestedInCloud":
                                                    trackBools[3].toString(),
                                                "interestedInOther":
                                                    otherTracksController.text,
                                              });
                                            }
                                            var userData = jsonEncode(body);
                                            var userDataObject = ParseObject(
                                                loginProvider.userRole !=
                                                        UserRoles.volunteer
                                                    ? 'Registrants'
                                                    : "Volunteers")
                                              ..set('userData', userData)
                                              ..set("status", false)
                                              ..set(
                                                  "uID",
                                                  FirebaseAuth.instance
                                                          .currentUser?.uid
                                                          .toString() ??
                                                      "");
                                            if (loginProvider.userRole ==
                                                UserRoles.volunteer) {
                                              userDataObject.set("logistics",
                                                  volunteerRolesBools[0]);

                                              userDataObject.set("email",
                                                  volunteerRolesBools[1]);

                                              userDataObject.set("registration",
                                                  volunteerRolesBools[2]);

                                              userDataObject.set("socialMedia",
                                                  volunteerRolesBools[3]);

                                              userDataObject.set("content",
                                                  volunteerRolesBools[4]);

                                              userDataObject.set("Flutter",
                                                  volunteerRolesBools[5]);

                                              userDataObject.set("Android",
                                                  volunteerRolesBools[6]);

                                              userDataObject.set("Web",
                                                  volunteerRolesBools[7]);

                                              userDataObject.set("Cloud",
                                                  volunteerRolesBools[8]);

                                              userDataObject.set(
                                                  "ML", volunteerRolesBools[9]);

                                              userDataObject.set(
                                                  "CommunityOutreach",
                                                  volunteerRolesBools[10]);
                                            }
                                            await userDataObject
                                                .save()
                                                .then((response) {
                                              if (response.success) {
                                                snackbar(context,
                                                    "Successfully Registered!",
                                                    isError: false);
                                                LoginProvider data =
                                                    Provider.of(context,
                                                        listen: false);
                                                data.showLoader();
                                                navigatorState.push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const DevFestNavHost()));
                                              } else {
                                                snackbar(context,
                                                    "Oops! Couldn't register. Please try again later!");
                                              }
                                            });
                                          } else {
                                            if (!gender.isNotEmpty) {
                                              snackbar(context,
                                                  "Please select your gender");
                                              loginProvider.hideLoader();
                                            }
                                            if (!iAmA.isNotEmpty) {
                                              snackbar(context,
                                                  "Please select your career status");
                                              loginProvider.hideLoader();
                                            }
                                            if (!pastGDGEvents.isNotEmpty) {
                                              snackbar(context,
                                                  "Please help us know if you've attended any of our past events");

                                              loginProvider.hideLoader();
                                            }
                                            if (trackBools
                                                    .where((element) => element)
                                                    .isEmpty &&
                                                loginProvider.userRole ==
                                                    UserRoles.attendee) {
                                              snackbar(context,
                                                  "Please select atleast one tech stack you're interested in");

                                              loginProvider.hideLoader();
                                            }
                                            if (volunteerRolesBools
                                                    .where((element) => element)
                                                    .isEmpty &&
                                                loginProvider.userRole ==
                                                    UserRoles.volunteer) {
                                              snackbar(context,
                                                  "Please select atleast one team you're volunteering for!");

                                              loginProvider.hideLoader();
                                            }

                                            loginProvider.hideLoader();
                                          }
                                        }
                                      },
                                      color: const Color(0xFFFBBC04),
                                      child: const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Text(
                                          "Register",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ]),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: Image.asset("assets/bottom_branding.png"),
                            )
                          ]),
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth <= 600 ? 0 : 36,
                  )
                ],
              );
            }),
          );
        }),
        Consumer<LoginProvider>(builder: (context, loginProvider, _) {
          return loginProvider.shouldShowLoader
              ? const LoaderScreen()
              : const SizedBox();
        }),
      ],
    );
  }
}
