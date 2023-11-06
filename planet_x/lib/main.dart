import 'package:flutter/material.dart';
import './ui/home.dart';

void main() {
  runApp(
    const MaterialApp(
      title: "Planetary Weight Check",
      home: Home(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
