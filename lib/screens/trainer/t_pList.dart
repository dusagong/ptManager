import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pt_manager/controller/auth_controller.dart';
import 'package:pt_manager/controller/traineeController.dart';

class T_Plist extends StatefulWidget {
  const T_Plist({super.key});

  @override
  State<T_Plist> createState() => _T_PlistState();
}

class _T_PlistState extends State<T_Plist> {
  late Future<List<DocumentSnapshot<Map<String, dynamic>>>> traineeDocuments;
    final TraineeController traineeController = Get.put(TraineeController());

  @override
  void initState() {
    super.initState();
    traineeDocuments = getTraineeDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원'),
        centerTitle: true,
        elevation: 0,
        //leading: ,
        actions: <Widget>[
          IconButton(onPressed: (){
            showAddTraineeDialog();
          }, icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
        future: traineeDocuments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No trainees found.');
          } else {
            return Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                ),
                child: Scrollbar(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var traineeData = snapshot.data?[index].data();
                        return Padding(
                          padding: EdgeInsets.fromLTRB(32, 10, 32, 0),
                          child: GestureDetector(
                            onTap: (){},
                            child: Container(
                                height: 72,
                                width: 250,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: CircleAvatar(
                                            radius: 27,
                                            backgroundImage: AssetImage('assets/trainer/profile.jpg'),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                          child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  traineeData!['email'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ]
                                          ),
                                        ),
                                      ],
                                    ),

                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 10,
                                    )
                                  ],
                                )
                            ),
                          )
                        );
                      },
                    )),
              ),
            );
          }
        },
      ),
    );
  }
  void showAddTraineeDialog() {
      TextEditingController newTraineeController = TextEditingController(); // Create a new controller

    Get.defaultDialog(
      title: 'Add Trainee',
      content: TextField(
        controller: newTraineeController,
        decoration: InputDecoration(hintText: 'Enter trainee document name'),
      ),
      confirm: ElevatedButton(
        onPressed: () async {
          String traineeDocumentName =
              newTraineeController.text;
          bool documentExists =
              await traineeController.checkTraineeDocumentExists(
                  traineeDocumentName);

          if (documentExists) {
            traineeController.addTraineeToUserMapping(traineeDocumentName);
          } else {
            // Handle document not found
          }

          Get.back(); // Close the dialog
        },
        child: Text('Add'),
      ),
    );
  }
}

//traineeData!['email']
Future<List<DocumentSnapshot<Map<String, dynamic>>>>
    getTraineeDocuments() async {
  // Get the currently logged-in user's UID.
  String loggedInUid = FirebaseAuth.instance.currentUser!.uid;

  // Replace 'Trainer' with the actual name of the Trainer collection.
  DocumentReference<Map<String, dynamic>> trainerDocRef =
      FirebaseFirestore.instance.collection('trainer').doc(loggedInUid);

  // Get the document snapshot of the logged-in Trainer.
  DocumentSnapshot<Map<String, dynamic>> trainerDocSnapshot =
      await trainerDocRef.get();

  // Get the user field (mapping) from the Trainer document data.
  Map<String, dynamic> userUidsMap = trainerDocSnapshot.data()?['user'];

  List<DocumentSnapshot<Map<String, dynamic>>> traineeDocuments = [];

  // Replace 'trainee' with the actual name of the trainee collection.
  CollectionReference<Map<String, dynamic>> traineeCollectionRef =
      FirebaseFirestore.instance.collection('trainee');

  // Fetch trainee documents based on each user UID in the userUidsMap.
  for (var userUid in userUidsMap.values) {
    DocumentSnapshot<Map<String, dynamic>> traineeDocument =
        await traineeCollectionRef.doc(userUid).get();
    traineeDocuments.add(traineeDocument);
  }

  // You can now use traineeDocuments to access the data for each trainee.
  return traineeDocuments;
}

// Usage
// List<DocumentSnapshot<Map<String, dynamic>>> traineeDocuments = await getTraineeDocuments();
// for (var traineeDocument in traineeDocuments) {
//   if (traineeDocument.exists) {
//     // Access the data for each trainee.
//     var traineeData = traineeDocument.data();
//     // ...
//   } else {
//     // Document for a trainee not found.
//   }
// }
