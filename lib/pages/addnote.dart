import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/pages/notelibrary.dart';

class AddNote extends StatefulWidget{
  @override
  _AddNoteState createState() => _AddNoteState();
}
class _AddNoteState extends State<AddNote> {
String? _title;
String? _description;

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: (){
                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NoteLibrary()));
                      },
                      child: const Icon(
                    Icons.arrow_back,
                    ),
      ),
                  ElevatedButton(
                      onPressed: add,
                      child: const Text(
                          "save",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Billie",
                        ),
                      ),
                  ),
                ],
              ),
            ),
            Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration.collapsed(
                          hintText: 'title'
                      ),
                      style: const TextStyle(
                          fontSize: 32.0,
                          fontFamily: "Billie",
                          fontWeight: FontWeight.bold
                      ), onChanged: (_val){
                        _title = _val;
                    },
                    ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    padding: const EdgeInsets.only(top: 12.0),
                    child: TextFormField(
                      decoration: const InputDecoration.collapsed(
                          hintText: 'note description'
                      ),
                      style: const TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Billie",
                          fontWeight: FontWeight.bold
                      ), onChanged: (_val){
                      _description = _val;
                    },
                      maxLines: 20,
                    ),
                  )

                  ],
                )
            )
          ],
        ),
      ),
    ));
  }

  void add(){
    // fix this tomorrow morning
  CollectionReference ref = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('notes');

    var data = {
      'title' : _title,
      'description' : _description,
    };

    ref.add(data);

    Navigator.pop(context);
  }

  }
