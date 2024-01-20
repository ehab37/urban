import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:urban/components/app_local.dart';

class MyIndicator {
  loading(BuildContext context) {
    return showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.white.withOpacity(0),
        child: SizedBox(
          //color: Colors.white.withOpacity(.1),
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(80.0),
            child: LiquidCircularProgressIndicator(
              value: .5,
              valueColor: AlwaysStoppedAnimation(
                  Theme.of(context).appBarTheme.backgroundColor!),
              backgroundColor: Colors.white.withOpacity(0),
              borderColor: Colors.white.withOpacity(0),
              borderWidth: 5.0,
              direction: Axis.vertical,
              center: Text(
                '${getLang(context, "Loading")}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget myCircularIndicator(context) {
  return Material(
      type: MaterialType.circle,
      color: Colors.white,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          color: Theme.of(context).appBarTheme.backgroundColor,
        ),
      ));
}

Widget myShimmer(context) {
  return Center(
    child: Material(
        type: MaterialType.circle,
        color: Colors.white,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            color: Theme.of(context).appBarTheme.backgroundColor,
          ),
        )),
  );
}
