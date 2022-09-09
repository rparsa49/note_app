import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/pages/notelibrary.dart';

class ViewNote extends StatefulWidget{

  final Map data;
  final DocumentReference ref;

  ViewNote(this.data, this.ref);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}
class _ViewNoteState extends State<ViewNote> {
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
                        onPressed: delete,
                       child: const Icon(
                        Icons.delete_outline,
                      ),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red.shade400)),
                      ),
                    ],
                  ),
                ),
                    Column(
                      children: [
                        Text(
                          "${widget.data['title']}",
                          style: const TextStyle(
                              fontSize: 32.0,
                              fontFamily: "Billie",
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.75,
                          child: Text(
                            "${widget.data['description']}",
                            style: const TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Billie",
                            )
                          ),
                        )

                      ],
                    )

              ],
            ),
          ),
        ));
  }

  void delete() async{
    await widget.ref.delete();
    Navigator.pop(context);
  }

}
