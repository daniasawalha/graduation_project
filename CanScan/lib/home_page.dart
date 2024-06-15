import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:braestcancer/image_list_page.dart'; // Import the image list page
import 'dart:convert';
import 'dart:typed_data';

class ImageUploader {
  Future<void> uploadImage(File imageFile, String idDoctor, String output) async {
    List<int> imageBytes = await imageFile.readAsBytes(); // Corrected method
    String base64Image = base64Encode(imageBytes);

    var uri = Uri.parse('http://192.168.1.18:5000/insert_img'); 

    try {
      http.Response response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "ID_DOCTOR": idDoctor,
        },
        body: jsonEncode({
          
          'image': base64Image,
          'state': output,
        }),
      );

      print('Image Upload Status Code: ${response.statusCode}');
      print('Image Upload Response Body: ${response.body}');
      print('Image Upload Response Body: $output');
      print('Image Upload Response Body: $idDoctor');
      print('Image Upload Response Body: $base64Image');

      if (response.statusCode == 200) {
        print('Image uploaded successfully.');
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred while uploading image: $e');
    }
  }
}

class HomePage extends StatefulWidget {
  final String idDoctor; // Accept doctor's ID as a parameter

  HomePage({required this.idDoctor});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;
  late File _image;
  late List _output;
  final picker = ImagePicker();
  bool modelResultObtained = false;

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  Future<void> loadModel() async {
    try {
      await Tflite.loadModel(
        model: "assets/classifier_modelhb.tflite",
        labels: "assets/labels.txt",
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: false,
      );
    } catch (e) {
      print("Failed to load model: $e");
    }
  }

  String output = ''; // Initialize output variable

  Future<void> detectImage(File image) async {
    var outputFromModel = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 3,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      loading = false;
      _output = outputFromModel ?? [];
      if (_output.isNotEmpty) {
        _output = _output.sublist(0, _output.length < 3 ? _output.length : 3);
        _output.forEach((element) {
          print("Label: ${element['label']}, Confidence: ${element['confidence']}");
        });

        // Extracting the output from the result
        output = _output[0]['label'].toString().substring(1); // Assuming the output format is 'G1', 'G2', etc.
      } else {
        // Handle empty results case (assign default value)
        output = "No Result";
      }
    });

    // Upload image with output
    if (output.isNotEmpty) {
      ImageUploader imageUploader = ImageUploader();
      String idDoctor = widget.idDoctor;
      await imageUploader.uploadImage(image, idDoctor, output);
    }
  }

  @override
  Future<void> dispose() async {
    await Tflite.close();
    super.dispose();
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      File? croppedFile = await _cropImage(File(pickedImage.path));
      if (croppedFile != null) {
        setState(() {
          _image = croppedFile;
          loading = true;
          modelResultObtained = true;
        });

        ImageUploader imageUploader = ImageUploader();
        String idDoctor = widget.idDoctor; // Use the doctor's ID from the widget parameter
        await detectImage(croppedFile);
      }
    }
  }

  Future<File?> _cropImage(File file) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
    );
    if (croppedFile != null) {
      return File(croppedFile.path);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    String idDoctor = widget.idDoctor; // Access doctor's ID from widget parameter

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cancer Scan',
          style: GoogleFonts.roboto(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10),
              Container(
                height: 150,
                width: 150,
                padding: EdgeInsets.all(10),
                child: Image.asset('assets/can.jpg'),
              ),
              
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _getImage(ImageSource.camera);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 253, 212, 226),
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: Text(
                                'Capture',
                                style: GoogleFonts.roboto(fontSize: 18),
                              ),
                            ),
                            SizedBox(height: 5),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _getImage(ImageSource.gallery);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: const Color.fromARGB(255, 253, 212, 226),
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: Text(
                                'Gallery',
                                style: GoogleFonts.roboto(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                
                style: 
                
                ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 253, 212, 226),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Scan Image',
                  style: GoogleFonts.roboto(fontSize: 18, color: Colors.black),
                ),
              ),
              SizedBox(height: 3), // Adjusted spacing
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImageListPage(idDoctor:idDoctor ,)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 253, 212, 226),// Set the same color for all buttons
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'View List of Images',
                  style: GoogleFonts.roboto(fontSize: 18,color: Colors.black),
                ),
              ),
              SizedBox(height: 3), // Adjusted spacing
              loading != true
                  ? Column(
                children: [
                  Container(
                    height: 220,
                    padding: EdgeInsets.all(15),
                    child: Image.file(_image),
                  ),
                  SizedBox(height: 10),
                  if (_output != null && _output.isNotEmpty)
                    Text(
                      _output[0]['label'] != null
                          ? _output[0]['label'].toString().substring(2)
                          : '',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: _output[0]['label'] != null &&
                            _output[0]['label']
                                .toString()
                                .contains('Grade_1')
                            ? Colors.green
                            : _output[0]['label'] != null &&
                            _output[0]['label']
                                .toString()
                                .contains('Grade_2')
                            ? Colors.yellow
                            : Colors.red,
                        fontWeight: FontWeight.bold, // Highlighting result
                      ),
                    ),
                  SizedBox(height: 10),
                  if (_output != null &&
                      _output.isNotEmpty &&
                      _output[0]['confidence'] != null)
                    Text(
                      'Confidence: ' +
                          _output[0]['confidence'].toString(),
                      style: GoogleFonts.roboto(fontSize: 18),
                    )
                ],
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
