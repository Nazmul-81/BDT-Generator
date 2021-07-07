import 'package:flutter/material.dart';

class MyErrorLoading {
  static show(snapshot) {
    if (snapshot.data == null) {
      return Center(
        child: Text('Something went wrong'),
      );
    }
    if (snapshot.hasError) {
      return Center(
        child: Text('Something went wrong'),
      );
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
