import 'package:flutter/cupertino.dart';

class MySnapShotError {
  static handle(snapshot) {
    if (snapshot.hasError) {
      return Center(
        child: Text('Something went wrong'),
      );
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(
        child: Text("Loading"),
      );
    }
  }
}
