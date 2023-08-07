import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TraineeController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference<Map<String, dynamic>> _trainerCollection =
      FirebaseFirestore.instance.collection('trainer');
  final CollectionReference<Map<String, dynamic>> _traineeCollection =
      FirebaseFirestore.instance.collection('trainee');

  Future<void> addTraineeToUserMapping(String traineeDocumentName) async {
    String loggedInUid = _auth.currentUser!.uid;

    DocumentSnapshot<Map<String, dynamic>> trainerDocSnapshot =
        await _trainerCollection.doc(loggedInUid).get();

    int userCount = trainerDocSnapshot.data()?['usercount'] ?? 0;
    userCount++;
    // String traineeUid = 'user${userCount}'; // Generate the new key name
    // await _trainerCollection.doc(loggedInUid).update({
    //   'user.$traineeUid': traineeDocumentName, // Assign the trainee UID
    //   'usercount': userCount, // Increment the usercount
    // });

    Map<String, dynamic> userUidsMap = trainerDocSnapshot.data()?['user'];
    userUidsMap['user${userCount}'] = traineeDocumentName;

    await _trainerCollection
        .doc(loggedInUid)
        .update({'user': userUidsMap, 'usercount': userCount});
  }

  Future<bool> checkTraineeDocumentExists(String traineeDocumentName) async {
    try {
      // Replace 'trainee' with the actual name of the trainee collection.
      DocumentSnapshot<Map<String, dynamic>> traineeDocumentSnapshot =
          await FirebaseFirestore.instance
              .collection('trainee')
              .doc(traineeDocumentName)
              .get();

      return traineeDocumentSnapshot.exists;
    } catch (e) {
      // Handle any errors that might occur during the query.
      print('Error checking trainee document existence: $e');
      return false;
    }
  }
}
