import 'package:devfest_vizag/login/registration_form_screen.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return constraints.maxWidth <= 600 ? Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Image.asset("assets/bottom_branding.png"),
          ),
          body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                            "Hola Developers! 🌟",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                              "Thank you for reaching us to be a part of one of the most awaited events of all time, DevFest Vizag 2022! 🤩🔥\n\nThis year, we've got eminent speakers for all the domains we’ve focused on to provide you with the best available aids out there.✨\nThis year we have individual sessions for Android, Flutter and ML/DS.\nNew to all of it? Well, we got you covered as well!😃\n\nSo then what are you waiting for, get enrolled!\nWait… But who are we to decide what domain you want to experience?🤐\n\nHere’s a solution.\n\nChoose the domain you are most enthusiastic about and give us a brief on why so? We’ll add you up to the particular session and you all can get quality information about your favourite domain to work with.🎇\n\nThen, What about the beginners?\nWell, we want you to choose what you are keen to know about and what exactly you want your takeaway to be in the Dev Fest Vizag 2022.😎\n\nSo, It’s time for you all to fill out the form now. See you there at the celebration!🎉\nJust splurge your self with goodness of the Google eventual- 🌟DEVFEST 2022! 🌟The holy grail! "
                              // "Lorem ipsum dolor sit amet, connectsor adipsicing alit.",
                              ),
                          const SizedBox(
                            height: 16,
                          ),
                          MaterialButton(
                            minWidth: double.infinity,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const RegistrationFormScreen()));
                            },
                            color: const Color(0xFFFBBC04),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                "Get Started",
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ]),
                  ),
                ]),
          ),
        ):   Scaffold(
          body: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.asset("assets/left_branding.png"),
          const SizedBox(
          width: 48,
          ),
          Expanded(child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
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
                            "Hola Developers! 🌟",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                              "Thank you for reaching us to be a part of one of the most awaited events of all time, DevFest Vizag 2022! 🤩🔥\n\nThis year, we've got eminent speakers for all the domains we’ve focused on to provide you with the best available aids out there.✨\nThis year we have individual sessions for Android, Flutter and ML/DS.\nNew to all of it? Well, we got you covered as well!😃\n\nSo then what are you waiting for, get enrolled!\nWait… But who are we to decide what domain you want to experience?🤐\n\nHere’s a solution.\n\nChoose the domain you are most enthusiastic about and give us a brief on why so? We’ll add you up to the particular session and you all can get quality information about your favourite domain to work with.🎇\n\nThen, What about the beginners?\nWell, we want you to choose what you are keen to know about and what exactly you want your takeaway to be in the Dev Fest Vizag 2022.😎\n\nSo, It’s time for you all to fill out the form now. See you there at the celebration!🎉\nJust splurge your self with goodness of the Google eventual- 🌟DEVFEST 2022! 🌟The holy grail! "
                            // "Lorem ipsum dolor sit amet, connectsor adipsicing alit.",
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          MaterialButton(
                            minWidth: double.infinity,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                  const RegistrationFormScreen()));
                            },
                            color: const Color(0xFFFBBC04),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                "Get Started",
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ]),
                  ),
                ]),
          ))]),
        );
      }
    );
  }
}
