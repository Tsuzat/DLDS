import 'package:dlds/classifier.dart';
import 'package:dlds/classifier_float.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_windows/image_picker_windows.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:logger/logger.dart';
import 'package:desktop_window/desktop_window.dart';

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
  Image? _imageWidget;
  late Classifier _classifier;
  var logger = Logger();
  String? label;
  String? score;

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
      _imageWidget = Image.file(
        File(
          _imagePath!,
        ),
      );
      _predict();
    }
    setState(() {});
  }

  void _predict() async {
    img.Image imageInput =
        img.decodeImage(File(_imagePath!).readAsBytesSync())!;
    var pred = _classifier.predict(imageInput);
    label = pred.label;
    score = (pred.score * 100).toStringAsFixed(2);
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
            ? const Text(
                "No Image Selected",
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            : Column(
                children: [
                  const Expanded(
                    child: SizedBox(),
                  ),
                  _imageWidget!,
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Category: ${label ?? 'Unknown'}\n Confidence: ${score ?? 'Unknown'}%",
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Expanded(
                    child: SizedBox(),
                  )
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: const Icon(
          Icons.image_search_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
