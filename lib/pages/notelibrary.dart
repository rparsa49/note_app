
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/pages/addnote.dart';
import 'package:note_app/pages/homepage.dart';
import 'package:note_app/pages/viewnote.dart';

class NoteLibrary extends StatefulWidget {
  @override
  _NoteLibraryState createState() => _NoteLibraryState();
}

class _NoteLibraryState extends State<NoteLibrary>{
  CollectionReference ref = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('notes');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text(
        'notes library',
        style: TextStyle(
          fontSize: 32.0,
          fontFamily: "Billie",
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddNote(),
              ),
            ).then((value){
              print("updating note library display");
              setState(() {
              });
            });
          },
          backgroundColor: Colors.blue.shade400,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
          FloatingActionButton(
              onPressed: (){
                FirebaseAuth.instance.signOut();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
              },
            backgroundColor: Colors.red.shade400,
            child: const Icon(
              Icons.power_settings_new_outlined
            ),
          ),
        ],
      ),
     body: FutureBuilder<QuerySnapshot>(
       future: ref.get(),
       builder: (context, snapshot) {
         if(snapshot.hasData) {
        return ListView.builder(
          itemCount: snapshot.data?.docs.length,

            itemBuilder: (context, index){
            Color background = Colors.yellow.shade700;
            Map data = {};
            data = snapshot.data?.docs[index].data() as Map;
            return InkWell(
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ViewNote(
                            data,
                            (snapshot.data!).docs[index].reference,
                        ),
                    ),
                ).then((value) {
                  setState(() {
                  });
                });
              },
            child: Card(
              color: background,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${data!['title']}",
                    style: const TextStyle(
                      fontSize: 27.0,
                      fontFamily: "Billie",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              )

            ));
            });
         } else {
           return  const Center(
             child: Text("loading.."),
           );
         }
       },
     )
    );
  }
}