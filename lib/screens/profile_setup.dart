import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'travel_animation_page.dart'; // Import the TravelAnimationPage instead

class ProfileSetupScreen extends StatefulWidget {
  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final picker = ImagePicker();
  String? _name, _number, _profession, _favoritePlaces, _nextTrip, _socialMediaLink;
  bool _frequentTraveler = false;

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)], // Light orange to peach gradient
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Set Up Your Profile',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5D4037), // Dark brown
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.photo_camera, color: Color(0xFF5D4037)),
                                    title: Text('Take a photo', style: TextStyle(color: Color(0xFF5D4037))),
                                    onTap: () {
                                      getImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.photo_library, color: Color(0xFF5D4037)),
                                    title: Text('Choose from gallery', style: TextStyle(color: Color(0xFF5D4037))),
                                    onTap: () {
                                      getImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Color(0xFFFFCC80), // Light orange
                        backgroundImage: _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? Icon(Icons.add_a_photo, size: 50, color: Color(0xFF5D4037))
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildTextField('Name', (val) => _name = val, isRequired: true),
                  _buildTextField('Phone Number', (val) => _number = val, isRequired: true),
                  _buildTextField('Profession (Optional)', (val) => _profession = val),
                  _buildTextField('Favorite Tourist Places', (val) => _favoritePlaces = val),
                  SwitchListTile(
                    title: Text('Do you travel frequently?', style: TextStyle(color: Color(0xFF5D4037))),
                    value: _frequentTraveler,
                    onChanged: (bool value) {
                      setState(() {
                        _frequentTraveler = value;
                      });
                    },
                    activeColor: Color(0xFFFFCC80),
                    activeTrackColor: Color(0xFFFFE0B2),
                  ),
                  _buildTextField('Next Trip (if planned)', (val) => _nextTrip = val),
                  _buildTextField('Social Media Link (Optional)', (val) => _socialMediaLink = val),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Navigate to the TravelAnimationPage
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => TravelAnimationPage()),
                          );
                        }
                      },
                      child: Text('Complete Setup'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFCC80), // Light orange
                        foregroundColor: Color(0xFF5D4037), // Dark brown
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String) onSaved, {bool isRequired = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Color(0xFF5D4037)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFFCC80)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF5D4037)),
          ),
        ),
        style: TextStyle(color: Color(0xFF5D4037)),
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'Please enter $label';
          }
          return null;
        },
        onSaved: (value) => onSaved(value!),
      ),
    );
  }
}
