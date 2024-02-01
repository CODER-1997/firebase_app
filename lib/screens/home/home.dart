import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController midname = TextEditingController();

  bool isEditScreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout_outlined))
        ],
        title: Text("Home"),
        backgroundColor: Colors.brown[400],
      ),
      body: isEditScreen == false
          ? StreamBuilder(
              stream: FirebaseFirestore.instance.collection('data').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  return Container(
                    padding: EdgeInsets.all(32),
                    height: 400,
                    child: Column(
                      children: [
                        Column(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start
                                ,
                                children: [
                                  Text(
                                    "Name: "+data['name'],
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  SizedBox(height: 16,),
                                  Text(
                                   "Surname: "+ data['surname'],
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  SizedBox(height: 16,),

                                  Text(
                                 "Midname: " +  data['midname'],
                                    style: TextStyle(fontSize: 22),
                                  ),


                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 16,),

                        Container(
                          width: double.infinity-32,
                          height: 66,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isEditScreen = true;
                              });
                            },
                            child: Text('Edit'),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Text('data');
                }
              },
            )
          : Container(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    TextFormField(
                      controller: name,
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: surname,
                      decoration: InputDecoration(labelText: 'Surname'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your surname';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: midname,
                      decoration: InputDecoration(labelText: 'Middle Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your midname';
                        }
                        return null;
                        // Middle name is optional, so no validation is required
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      width: 300,
                      height: 66,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FirebaseFirestore.instance
                                .collection('data').doc('u923hAOcvjW2DIVfApcE').update
                                ({
                                  'name': name.text,
                                  'surname': surname.text,
                                  "midname": midname.text
                                })
                                .then((value) =>
                                    print('Data stored successfully'))
                                .catchError((error) =>
                                    print('Failed to store data: $error'));
                          }
                          setState(() {
                            isEditScreen = false;
                          });
                        },
                        child: Text('Edit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
