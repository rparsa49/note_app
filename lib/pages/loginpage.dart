import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/pages/homepage.dart';
import 'package:note_app/pages/notelibrary.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _email;
  late String _password;
  final auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Column(
            children: [
              const Padding(
                  padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
                    child: Text('Login or Sign up to Continue', style: TextStyle(fontSize: 40, fontFamily: 'Billie', fontWeight: FontWeight.bold),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 130, 16, 0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      hintText: 'email'
                  ),
                  onChanged: (value) {
                    setState(() {
                      _email = value.trim();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
                child: TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: 'password'
                  ),
                  onChanged: (value) {
                    setState(() {
                      _password = value.trim();
                    });
                  },
                ),
              ),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:[
                    ElevatedButton(
                        child: const Text('Sign in'),
                        onPressed: (){
                          var user = auth.signInWithEmailAndPassword(email: _email, password: _password);
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NoteLibrary()));
                        }
                    ),
                    ElevatedButton(
                        child: const Text('Sign up'),

                        onPressed:(){
                          var user = auth.createUserWithEmailAndPassword(email: _email, password: _password);
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NoteLibrary()));
                        })
                  ])
            ]
        )
    );
  }
}