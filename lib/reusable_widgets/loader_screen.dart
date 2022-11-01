import 'package:flutter/material.dart';

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
      body: LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: ClipOval(
            child: CircleAvatar(
              radius: getProportionateHeight(170, constraints),
              backgroundColor: Theme.of(context).primaryColor,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    "assets/top_branding.png",
                    width: getProportionateHeight(340, constraints),
                  ),
                  Spacer(),
                  Text(
                    "Please Wait Until We\nLoad Your Data...".toUpperCase(),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onPrimary),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

double getProportionateHeight(double height, BoxConstraints constraints) {
  return (constraints.maxHeight / 926) * height;
}

double getProportionateWidth(double width, BoxConstraints constraints) {
  return (constraints.maxWidth / 428) * width;
}
