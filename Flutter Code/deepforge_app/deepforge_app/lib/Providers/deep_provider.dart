import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:image_picker/image_picker.dart';

class DeepProvider with ChangeNotifier {
  final FlutterVision _vision = FlutterVision();
  bool _isModelLoaded = false;
  bool _isLoading = false;
  File? _imageFile;
  List<Map<String, dynamic>> _yoloResults = [];
  int _imageHeight = 1;
  int _imageWidth = 1;
  String _errorMessage = '';

  bool get isModelLoaded => _isModelLoaded;
  File? get imageFile => _imageFile;
  List<Map<String, dynamic>> get yoloResults => _yoloResults;
  int get imageHeight => _imageHeight;
  int get imageWidth => _imageWidth;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  void clearErrorMessage() {
    _errorMessage = '';
    notifyListeners();
  }


  set isModelLoaded(bool value) {
    _isModelLoaded = value;
    notifyListeners();
  }

  void removeImage() {
   _imageFile = null;
   _yoloResults.clear();
   _errorMessage = '';
  notifyListeners();
 }

  Future<void> loadYoloModel() async {
    await _vision.loadYoloModel(
      labels: 'assets/labels.txt',
      modelPath: 'assets/yolo.tflite',
      modelVersion: "yolov8",
      quantization: false,
      numThreads: 2,
      useGpu: true,
    );
    print('working');
    _isModelLoaded = true;
    notifyListeners();
  }

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
      if (photo != null) {
        notifyListeners();
        _imageFile = File(photo.path);
      }
    } catch (e) {
      print('Image not pick $e');
    }
  }

  Future<void> detectObjects() async {
    _isLoading = true;
    notifyListeners();

    yoloResults.clear();
    Uint8List imageBytes = await _imageFile!.readAsBytes();
    final image = await decodeImageFromList(imageBytes);
    _imageHeight = image.height;
    _imageWidth = image.width;
    final results = await _vision.yoloOnImage(
      bytesList: imageBytes,
      imageHeight: image.height,
      imageWidth: image.width,
      iouThreshold: 0.8,
      confThreshold: 0.4,
      classThreshold: 0.5,
    );
    _isLoading = false;
    if (results.isNotEmpty) {
      _yoloResults = results;
      _errorMessage = 'Forgery Detected';
    } else {
      _errorMessage = 'No Forged object detected';
    }
    notifyListeners();
  }

  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
    if (_isLoading || yoloResults.isEmpty) return [];

    double factorX = screen.width / (imageWidth);
    double imgRatio = imageWidth / imageHeight;
    double newWidth = imageWidth * factorX;
    double newHeight = newWidth / imgRatio;
    double factorY = newHeight / (imageHeight);

    double pady = (screen.height - newHeight) / 2;

    Color colorPick = Color.fromARGB(98, 50, 233, 30);
    return yoloResults.map((result) {
      return Positioned(
        left: result["box"][0] * factorX,
        top: result["box"][1] * factorY + pady,
        width: (result["box"][2] - result["box"][0]) * factorX,
        height: (result["box"][3] - result["box"][1]) * factorY,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.pink, width: 2.0),
          ),
          child: Text(
            "${result['tag']} ${(result['box'][4] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = colorPick,
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      );
    }).toList();
  }
}
