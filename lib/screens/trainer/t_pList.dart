import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pt_manager/controller/auth_controller.dart';

class T_Plist extends StatefulWidget {
  const T_Plist({super.key});

  @override
  State<T_Plist> createState() => _T_PlistState();
}

class _T_PlistState extends State<T_Plist> {
  late Future<List<DocumentSnapshot<Map<String, dynamic>>>> traineeDocuments;

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
        actions: [Icon(Icons.search)],
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
            return Container(
              height: 400,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Scrollbar(
                  child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var traineeData = snapshot.data?[index].data();
                  return ListTile(
                    title: Text(traineeData!['name']),
                    subtitle: Text(traineeData['email']),
                    // Customize the list tile as needed.
                  );
                },
              )),
            );
          }
        },
      ),
    );
  }
}

Future<List<DocumentSnapshot<Map<String, dynamic>>>>
    getTraineeDocuments() async {
  // Get the currently logged-in user's UID.
  String loggedInUid = FirebaseAuth.instance.currentUser!.uid;

  // Replace 'Trainer' with the actual name of the Trainer collection.
  DocumentReference<Map<String, dynamic>> trainerDocRef =
      FirebaseFirestore.instance.collection('Trainer').doc(loggedInUid);

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