import 'dart:io';
import 'package:banana_fashion/screens/select_photo_options_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const id = 'set_photo_screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controllerText = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..forward();
  late final Animation<double> _animationText =
      Tween(begin: 0.0, end: 1.0).animate(_controllerText);

  File? _image;

  @override
  void initState() {
    super.initState();
  }

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  changeImage(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('image_profile', path);
  }

  Future<String?> getImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? image = prefs.getString('image_profile');
    if (image != null) {
      _image = File(image);
    }
    return image;
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      setState(() {
        _image = img;
        changeImage(image.path);
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    final txtNombre = Text(user.displayName != null ? user.displayName! : '',
        style: TextStyle(fontFamily: 'Roundman', fontSize: 20));

    final txtCorreo = Text(user.email!,
        style: TextStyle(fontFamily: 'Roundman', fontSize: 20));

    final spaceHorizontal = SizedBox(
      height: 10,
    );

    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: FadeTransition(
                      opacity: _animationText,
                      child: Center(
                        child: FirebaseAuth.instance.currentUser!
                                .providerData[0].providerId
                                .toLowerCase()
                                .contains('password')
                            ? GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  _showSelectPhotoOptions(context);
                                },
                                child: Center(
                                  child: Container(
                                      height: 130.0,
                                      width: 130.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.shade200,
                                      ),
                                      child: FutureBuilder(
                                          future: getImage(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const CircularProgressIndicator();
                                            } else if (snapshot.hasError) {
                                              return const Text(
                                                  'Error al obtener los datos');
                                            } else {
                                              return Center(
                                                child: _image == null
                                                    ? const Text(
                                                        'No image selected',
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )
                                                    : CircleAvatar(
                                                        backgroundImage:
                                                            FileImage(_image!),
                                                        radius: 200.0,
                                                      ),
                                              );
                                            }
                                          })),
                                ),
                              )
                            : CircleAvatar(
                                radius: 80,
                                backgroundImage: NetworkImage(user.photoURL!),
                              ),
                      ),
                    ),
                  ),
                  FadeTransition(opacity: _animationText, child: txtNombre),
                  spaceHorizontal,
                  FadeTransition(opacity: _animationText, child: txtCorreo),
                  spaceHorizontal,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
