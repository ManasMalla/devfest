import 'package:devfest_vizag/login/login_provider.dart';
import 'package:devfest_vizag/login/login_screen.dart';
import 'package:devfest_vizag/login/registration_screen.dart';
import 'package:devfest_vizag/main.dart';
import 'package:devfest_vizag/util/string_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserType extends StatefulWidget {
  const UserType({Key? key}) : super(key: key);

  @override
  State<UserType> createState() => _UserTypeState();
}

enum UserRoles { attendee, speaker, volunteer, organizer, unknown }

class _UserTypeState extends State<UserType> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return constraints.maxWidth <= 600
          ? Scaffold(
              body: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/top_branding.png"),
                      const SizedBox(
                        height: 48,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Identify your role",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Text(
                              "Alone we can do so little; together we can do so much!",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Consumer<LoginProvider>(
                          builder: (context, loginProvider, _) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: ListView.separated(
                            primary: false,
                            shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 16,
                              );
                            },
                            itemBuilder: (context, index) {
                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: loginProvider.userRole ==
                                          UserRoles.values[index]
                                      ? MaterialButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          onPressed: () {
                                            loginProvider.setUserRole(
                                                UserRoles.values[index]);
                                            Navigator.maybeOf(context)?.push(
                                                MaterialPageRoute(
                                                    builder: (context) => FirebaseAuth
                                                                .instance
                                                                .currentUser ==
                                                            null
                                                        ? const LandingScreen()
                                                        : const RegistrationScreen()));
                                          },
                                          color: const Color(0xFFFBBC04),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              UserRoles.values[index]
                                                  .toString()
                                                  .replaceAll("UserRoles.", "")
                                                  .titleCase,
                                            ),
                                          ),
                                        )
                                      : OutlinedButton(
                                          onPressed: () {
                                            loginProvider.setUserRole(
                                                UserRoles.values[index]);
                                            Navigator.maybeOf(context)?.push(
                                                MaterialPageRoute(
                                                    builder: (context) => FirebaseAuth
                                                                .instance
                                                                .currentUser ==
                                                            null
                                                        ? const LandingScreen()
                                                        : const RegistrationScreen()));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              UserRoles.values[index]
                                                  .toString()
                                                  .replaceAll("UserRoles.", "")
                                                  .titleCase,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button
                                                  ?.copyWith(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              251,
                                                              127,
                                                              4)),
                                            ),
                                          ),
                                        ),
                                ),
                              );
                            },
                            itemCount: 4,
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 24,
                      ),
                    ]),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Image.asset("assets/bottom_branding.png"),
              ),
            )
          : Scaffold(
              body:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Image.asset("assets/left_branding.png"),
                const SizedBox(
                  width: 48,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 48),
                        Text(
                          "Identify your role",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Text(
                          "Alone we can do so little; together we can do so much!",
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Consumer<LoginProvider>(
                            builder: (context, loginProvider, _) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: ListView.separated(
                              primary: false,
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 16,
                                );
                              },
                              itemBuilder: (context, index) {
                                return AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: loginProvider.userRole ==
                                            UserRoles.values[index]
                                        ? MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            onPressed: () {
                                              loginProvider.setUserRole(
                                                  UserRoles.values[index]);
                                              Navigator.maybeOf(context)?.push(
                                                  MaterialPageRoute(
                                                      builder: (context) => FirebaseAuth
                                                                  .instance
                                                                  .currentUser ==
                                                              null
                                                          ? const LandingScreen()
                                                          : const RegistrationScreen()));
                                            },
                                            color: const Color(0xFFFBBC04),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                UserRoles.values[index]
                                                    .toString()
                                                    .replaceAll(
                                                        "UserRoles.", "")
                                                    .titleCase,
                                              ),
                                            ),
                                          )
                                        : OutlinedButton(
                                            onPressed: () {
                                              loginProvider.setUserRole(
                                                  UserRoles.values[index]);
                                              Navigator.maybeOf(context)?.push(
                                                  MaterialPageRoute(
                                                      builder: (context) => FirebaseAuth
                                                                  .instance
                                                                  .currentUser ==
                                                              null
                                                          ? const LandingScreen()
                                                          : const RegistrationScreen()));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                UserRoles.values[index]
                                                    .toString()
                                                    .replaceAll(
                                                        "UserRoles.", "")
                                                    .titleCase,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .button
                                                    ?.copyWith(
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 251, 127, 4)),
                                              ),
                                            ),
                                          ),
                                  ),
                                );
                              },
                              itemCount: 4,
                            ),
                          );
                        }),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Image.asset("assets/bottom_branding.png"),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            );
      ;
    });
  }
}
