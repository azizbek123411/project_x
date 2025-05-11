import 'package:flutter/material.dart';

void ShowLoadingCircle(BuildContext context){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content:  Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
}


void hideLoadingCircle(BuildContext context){
  Navigator.pop(context);
}