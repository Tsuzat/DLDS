import 'package:dlds/classifier.dart';
import 'package:dlds/classifier_float.dart';
import 'package:dlds/percentage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_windows/image_picker_windows.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:logger/logger.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:lottie/lottie.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  testWindowFunction();
  runApp(const MyApp());
}

void testWindowFunction() async {
  await DesktopWindow.setWindowSize(const Size(500, 800));
  await DesktopWindow.setMinWindowSize(const Size(500, 800));
  await DesktopWindow.setMaxWindowSize(const Size(500, 800));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Deep Learning Defect Sampling",
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _imagePath;
  late Classifier _classifier;
  var logger = Logger();
  String? label;
  double? score;

  @override
  void initState() {
    super.initState();
    _classifier = ClassifierFloat();
  }

  Future getImage() async {
    final pickedFile =
        await ImagePickerWindows().getImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      _imagePath = null;
    } else {
      _imagePath = pickedFile.path;
      _predict();
    }
    setState(() {});
  }

  void _predict() async {
    img.Image imageInput =
        img.decodeImage(File(_imagePath!).readAsBytesSync())!;
    var pred = _classifier.predict(imageInput);
    label = pred.label;
    score = (pred.score * 100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Deep Learnig Defect Sampling",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: _imagePath == null
            ? defaultImage()
            : Column(
                children: [
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Image.file(
                    File(
                      _imagePath!,
                    ),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    label ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  percentage(
                    title: Text(
                      "${score!.toStringAsFixed(2)} %",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    background: Colors.lightGreenAccent,
                    foreground: Colors.lightGreen,
                    width: 200,
                    height: 20,
                    maximum: 100,
                    borderRadius: 5,
                    value: score!,
                  ),
                  const Expanded(
                    child: SizedBox(),
                  )
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: "Select Image",
        child: const Icon(
          Icons.image_search_rounded,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Column defaultImage() {
  return Column(
    children: [
      const Expanded(
        child: SizedBox(),
      ),
      Lottie.asset(
        "assets/defaultImage.json",
        width: 200,
        height: 200,
      ),
      const Text(
        "No Image Selected",
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      const Expanded(
        child: SizedBox(),
      ),
    ],
  );
}
