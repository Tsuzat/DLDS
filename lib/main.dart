import 'package:dlds/classifier.dart';
import 'package:dlds/classifier_float.dart';
import 'package:dlds/percentage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_windows/image_picker_windows.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:logger/logger.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

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
  int? predictionTime;

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
    var sw = Stopwatch()..start();
    img.Image imageInput =
        img.decodeImage(File(_imagePath!).readAsBytesSync())!;
    var pred = _classifier.predict(imageInput);
    label = pred.label;
    score = (pred.score * 100);
    predictionTime = sw.elapsed.inMilliseconds;
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
                  TextButton(
                    onPressed: () {
                      Map<String, dynamic> toCopy = {
                        "imagePath": _imagePath,
                        "Category": label,
                        "Score": score!.toStringAsFixed(2),
                      };
                      String data = jsonEncode(toCopy);
                      Clipboard.setData(
                        ClipboardData(
                          text: data,
                        ),
                      );
                      FlutterToastr.show(
                        "Copied in ClipBoard",
                        context,
                        duration: FlutterToastr.lengthShort,
                        position: FlutterToastr.bottom,
                        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.6),
                      );
                      setState(() {});
                    },
                    child: const Text(
                      "Copy Result",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.file(
                    File(
                      _imagePath!,
                    ),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
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
                  const SizedBox(
                    height: 5,
                  ),
                  predictionTime != null
                      ? Text(
                          "Completed in $predictionTime ms",
                        )
                      : const SizedBox(),
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
