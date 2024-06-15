import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImageListPage extends StatefulWidget {
  final String idDoctor;

  ImageListPage({required this.idDoctor});

  @override
  _ImageListPageState createState() => _ImageListPageState();
}

class _ImageListPageState extends State<ImageListPage> {
  List<Map<String, dynamic>> imageInfoList = [];

  @override
  void initState() {
    super.initState();
    _fetchImageInfo();
  }

  Future<void> _fetchImageInfo() async {
    print('Fetching image info for doctor ID: ${widget.idDoctor}');

    var uri = Uri.parse('http://192.168.1.18:5000/list_imgs');
    try {
      http.Response response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "ID_DOCTOR": widget.idDoctor,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data.containsKey('imageInfo') && data['imageInfo'] is List) {
          List<dynamic> infoList = data['imageInfo'];

          List<Map<String, dynamic>> processedList = [];
          for (var imageInfo in infoList) {
            String name = imageInfo['name'];
            int index = name.indexOf('G');
            if (index != -1 && index + 1 < name.length) {
              String extracted = name.substring(index, index + 2);
              processedList.add({'name': extracted, 'base64': imageInfo['base64']});
            }
          }

          setState(() {
            imageInfoList = processedList;
          });
        } else {
          print('Invalid response format: $data');
        }
      } else {
        print('Failed to fetch image info. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred while fetching image info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image List'),
      ),
      body: ListView.builder(
        itemCount: imageInfoList.length,
        itemBuilder: (context, index) {
          String name = imageInfoList[index]['name'];
          String base64Image = imageInfoList[index]['base64'];
          return GestureDetector(
            onTap: () {
              _showImageDialog(base64Image);
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Image.memory(
                      base64.decode(base64Image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(name),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showImageDialog(String base64Image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: InteractiveViewer(
              boundaryMargin: EdgeInsets.all(20),
              minScale: 0.1,
              maxScale: 4.0,
              child: Image.memory(
                base64.decode(base64Image),
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }
}
