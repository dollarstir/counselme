import 'package:flutter/material.dart';

int generateuid(){
  return  DateTime.now().microsecondsSinceEpoch.remainder(2);
}