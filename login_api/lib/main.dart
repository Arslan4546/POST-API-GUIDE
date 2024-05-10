import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/material.dart';
//first of all you should learn about how to post API  on the server
// https://youtu.be/pUGmhtqVJRk?si=mcBB8iyZ2VMIcLPH
//then make this project or overview this project

void main(){
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void login(String email,String password) async {
    try{
      Response response = await post(
        Uri.parse("https://reqres.in/api/login"),
        body: {
          //you should give these parameter same as in your json data
          "email": email,
          "password": password,
        }
      );
      if(response.statusCode==200){
        var data = jsonDecode(response.body.toString());
        print(data["token"]);
        print("Login Successfully");

      }else{
        print("Faliled");
      }
    } catch(e){
          print(e.toString());
    }
  }
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
            title: const Text("Login API",style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
           color: Colors.white
            ),),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               TextFormField(
                 controller: emailController,
                 decoration: const InputDecoration(
                   hintText:"email",
                 ),

               ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText:"password"
                ),

              ),

              const SizedBox(height: 40,),

        GestureDetector(
                onTap: (){
                  login(emailController.text.toString(),passwordController.text.toString());
                },
                child: Container(
                  height: 50,
                  decoration:  BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child:const Center(
                    child: Text("Login",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),),
                  ),
                ),
              )
              ],
          ),
        ),
      ),
    );
  }
}
// overview this video then overview this project