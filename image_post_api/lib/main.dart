import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart'as http;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;
  
  
  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 80);

    if(pickedFile!=null){
      image = File(pickedFile.path);
      setState(() {

      });
    }else{
      print("No Image Selected");

    }
  }

  Future <void> uploadImage() async {
    setState(() {
          showSpinner = true;
    });

    var stream = new http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    var uri = Uri.parse("https://fakestoreapi.com/products");

     var request = new http.MultipartRequest("POST",uri);
         request.fields["title"] = "static title";


         var multiport = new http.MultipartFile("image", stream, length);

         request.files.add(multiport);

         var response = await request.send();
         if(response.statusCode==200){
           setState(() {
             showSpinner = false;
           });
           print("sucessully uploaded");

         }else{
           setState(() {
             showSpinner = false;
           });
           print("Failed");
         }
  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
             onTap:  (){
              getImage();
        },
                child: Container(
                  child: image == null ? const Center(
                    child: Text("Pick Image"),
                  ):
                      Container(
                        child: Center(
                          child: Image.file(
                            File(image!.path).absolute,
                            height: 100,
                            width: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                ),
              ),
              const SizedBox(height: 100,),

              GestureDetector(
                onTap: (){
                  uploadImage();
                },
                child: Container(
                  color: Colors.blue,
                  height: 50,
                  width: 100,
                  child: const Center(
                      child: Text("upload")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
