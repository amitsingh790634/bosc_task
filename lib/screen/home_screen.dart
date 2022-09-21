import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../models/notes_operation.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late String titleText;
    late String descriptionText;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff003973), Color(0xffE5E5BE)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Padding(
                      padding: EdgeInsets.only(
                        top: 15,
                        left: 15,
                        right: 15,
                        bottom: 15,
                      ),
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Title',
                              hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            onChanged: (value) {
                              titleText = value;
                            },
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Description',
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              onChanged: (value) {
                                descriptionText = value;
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: TextButton(
                              onPressed: () {
                                Provider.of<NotesOperation>(context,
                                        listen: false)
                                    .addNewNote(titleText, descriptionText);
                                Navigator.pop(context);
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.only(
                                    left: 30, right: 30, top: 15, bottom: 15),
                                backgroundColor: Color(0xff003973),
                              ),
                              child: Center(
                                child: Text('Add Note',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
          child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle, // circular shape
                gradient: LinearGradient(
                  colors: [
                    Color(0xff2AAB0),
                    Color(0xffE5E5BE),
                  ],
                ),
              ),
              child: Icon(Icons.add, size: 30, color: Colors.red)),
          backgroundColor: Colors.white,
        ),
        appBar: AppBar(
          title: Text(
            'Task Application',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Consumer<NotesOperation>(
          builder: (context, NotesOperation data, child) {
            return ListView.builder(
              itemCount: data.getNotes.length,
              itemBuilder: (context, index) {
                return NotesCard(data.getNotes[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

class NotesCard extends StatelessWidget {
  final Note note;

  NotesCard(this.note);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        shape: BoxShape.rectangle,
        color: Color(0xff0575E6).withOpacity(0.5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 1.0,
            offset: Offset(5.0, 5.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.title,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          SizedBox(height: 5),
          Text(
            note.description,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
