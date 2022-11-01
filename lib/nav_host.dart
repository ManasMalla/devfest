import 'dart:convert';

import 'package:devfest_vizag/login/login_provider.dart';
import 'package:devfest_vizag/main.dart';
import 'package:devfest_vizag/reusable_widgets/loader_screen.dart';
import 'package:devfest_vizag/reusable_widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:provider/provider.dart';

import 'login/user_type.dart';

class DevFestNavHost extends StatefulWidget {
  const DevFestNavHost({Key? key}) : super(key: key);

  @override
  State<DevFestNavHost> createState() => _DevFestNavHostState();
}

class _DevFestNavHostState extends State<DevFestNavHost> {
  Future<void> fetchDataInBG() async {
    LoginProvider provider = Provider.of(context, listen: false);

    final QueryBuilder<ParseObject> parseQuery = QueryBuilder<ParseObject>(
        ParseObject(provider.userRole == UserRoles.volunteer
            ? "Volunteers"
            : 'Registrants'));
    parseQuery.whereContains(
        "uID", FirebaseAuth.instance.currentUser?.uid ?? "");

    var responses = await parseQuery.query();
    if (responses.success && responses.results != null) {
      if (responses.results!.isNotEmpty) {
        var isApplicationAccepted =
            (responses.results!.first as ParseObject).get("status") &&
                (responses.results!.first as ParseObject).get("registration");
        if (provider.userRole == UserRoles.volunteer) {
          isApplicationAccepted = isApplicationAccepted &&
              (responses.results!.first as ParseObject).get("canAccessData");
        }
        if (isApplicationAccepted) {
          provider.setApplicationAccepted();
          //Fetch user registration data
          final QueryBuilder<ParseObject> parseQueryOfRegistrants =
              QueryBuilder<ParseObject>(ParseObject('Registrants'));
          parseQueryOfRegistrants.whereEqualTo("status", false);
          parseQueryOfRegistrants.setLimit(3000);
          var responsesOfRegistrants = await parseQueryOfRegistrants.query();
          if (responsesOfRegistrants.success &&
              responsesOfRegistrants.results != null) {
            if (responsesOfRegistrants.results!.isNotEmpty) {
              for (var dataResponse in responsesOfRegistrants.results!) {
                var dataResponseJSON =
                    jsonDecode((dataResponse as ParseObject).get("userData"));
                if (!provider.dataOfRegistrants
                    .map((e) => e["name"])
                    .contains(dataResponseJSON["name"])) {
                  provider.dataOfRegistrants.add(dataResponseJSON);
                }
              }
              provider.uniqueOrganizations = provider.dataOfRegistrants
                  .map((e) => e["organization"].toString().toLowerCase())
                  .toSet()
                  .toList();
              provider.uniqueCities = provider.dataOfRegistrants
                  .map((e) => e["city"].toString().toLowerCase())
                  .toSet()
                  .toList();
              print(provider.dataOfRegistrants.length);
              provider.notifyListeners();
              provider.hideLoader();
            } else {
              snackbar(context, "Please try again later!");
              provider.hideLoader();
            }
          } else {
            snackbar(context, "Please try again later!");
            provider.hideLoader();
          }
        } else {
          provider.setApplicationPending();

          provider.hideLoader();
        }
      } else {
        snackbar(context, "Please try again later!");
        provider.hideLoader();
      }
    } else {
      snackbar(context, "Please try again later!");
      provider.hideLoader();
    }
  }

  @override
  void initState() {
    super.initState();

    fetchDataInBG();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, data, _) {
      return Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image.asset("assets/left_branding.png"),
            const SizedBox(
              width: 48,
            ),
            Expanded(
              child: data.userRole == UserRoles.attendee
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          constraints.maxWidth <= 600
                              ? Image.asset("assets/top_branding.png")
                              : const SizedBox(),
                          const SizedBox(
                            height: 48,
                          ),
                          !data.shouldShowLoader
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Center(
                                        child: Icon(
                                          Icons.verified_rounded,
                                          color: data.isApplicationPending
                                              ? Theme.of(context).primaryColor
                                              : Color(0xFF34A853),
                                          size: 56,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 56,
                                      ),
                                      Text(
                                        data.isApplicationPending
                                            ? "Your application has been submitted successfully and is being reviewed"
                                            : "Hurray!",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        data.isApplicationPending
                                            ? "Come back again soon to check the status of your application"
                                            : "You've been shortlisted for the DevFest Vizag 2022 edition!",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                    ],
                                  ),
                                )
                              : const Expanded(child: LoaderScreen()),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Image.asset("assets/bottom_branding.png"),
                          ),
                        ])
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          constraints.maxWidth <= 600
                              ? Image.asset("assets/top_branding.png")
                              : const SizedBox(),
                          const SizedBox(
                            height: 48,
                          ),
                          !data.shouldShowLoader
                              ? data.isApplicationPending
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Center(
                                          child: Icon(
                                            Icons.verified_rounded,
                                            color: data.isApplicationPending
                                                ? Theme.of(context).primaryColor
                                                : Color(0xFF34A853),
                                            size: 56,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 56,
                                        ),
                                        Text(
                                          data.isApplicationPending
                                              ? "Your application has been submitted successfully and is being reviewed"
                                              : "Hurray!",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          data.isApplicationPending
                                              ? "Come back again soon to check the status of your application"
                                              : "You've been shortlisted for the DevFest Vizag 2022 edition!",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                      ],
                                    )
                                  : Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Text("Organization",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge)),
                                              Expanded(
                                                  child: Text("City",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge))
                                            ],
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: SingleChildScrollView(
                                                    child: ListView.separated(
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        itemBuilder: (context,
                                                            indexOfRegistrant) {
                                                          return Text(
                                                              "${data.uniqueOrganizations[indexOfRegistrant].toString().capitalize()}: ${data.dataOfRegistrants.map((e) => e["organization"].toString().toLowerCase()).where((element) => element == data.uniqueOrganizations[indexOfRegistrant]).length}");
                                                        },
                                                        separatorBuilder:
                                                            (_, __) {
                                                          return Divider();
                                                        },
                                                        itemCount: data
                                                            .uniqueOrganizations
                                                            .length),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: SingleChildScrollView(
                                                    child: ListView.separated(
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        itemBuilder: (context,
                                                            indexOfRegistrant) {
                                                          return Text(
                                                              "${data.uniqueCities[indexOfRegistrant].toString().capitalize()}: ${data.dataOfRegistrants.map((e) => e["city"].toString().toLowerCase()).where((element) => element == data.uniqueCities[indexOfRegistrant]).length}");
                                                        },
                                                        separatorBuilder:
                                                            (_, __) {
                                                          return Divider();
                                                        },
                                                        itemCount: data
                                                            .uniqueCities
                                                            .length),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "Registrant Data",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: ListView.separated(
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  itemBuilder: (context,
                                                      indexOfRegistrant) {
                                                    return InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return Container(
                                                                color: Colors
                                                                    .white,
                                                                child: ListView
                                                                    .builder(
                                                                  primary:
                                                                      false,
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemBuilder:
                                                                      (context,
                                                                          _) {
                                                                    return Text(
                                                                        "${data.dataOfRegistrants[indexOfRegistrant].keys.toList()[_]}: ${data.dataOfRegistrants[indexOfRegistrant].values.toList()[_]}");
                                                                  },
                                                                  itemCount: data
                                                                      .dataOfRegistrants[
                                                                          indexOfRegistrant]
                                                                      .values
                                                                      .length,
                                                                ),
                                                              );
                                                            });
                                                      },
                                                      child: Text(
                                                          data.dataOfRegistrants[
                                                                  indexOfRegistrant]
                                                              ["name"]),
                                                    );
                                                  },
                                                  separatorBuilder: (_, __) {
                                                    return Divider();
                                                  },
                                                  itemCount: data
                                                      .dataOfRegistrants
                                                      .length),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                              : const Expanded(child: LoaderScreen()),
                          SizedBox(
                            height: 24,
                          ),
                          data.userRole == UserRoles.volunteer
                              ? SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32),
                                  child:
                                      Image.asset("assets/bottom_branding.png"),
                                ),
                        ]),
            )
          ]);
        }),
      );
    });
  }
}
