import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  ////////////////////////
  // int latestMappingNumber = 0;
  // void onInit() {
  //   super.onInit();
  //   _loadLatestMappingNumber();
  // }

  // Future<void> _loadLatestMappingNumber() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   latestMappingNumber = prefs.getInt('latestMappingNumber') ?? 0;
  // }

  Future<void> createDietDocument(String userUid, String foodImage, String menu,
      String memo, DateTime date, String formattedDate) async {
    try {
      // Get a reference to the user's document in the "trainee" collection
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('trainee').doc(userUid);

      // Get the user's "Food" document
      DocumentSnapshot<Map<String, dynamic>> foodDocSnapshot =
          await userRef.collection('Food').doc(formattedDate).get();
      Map<String, dynamic> foodData = foodDocSnapshot.data() ?? {};

      // Get the existing mappings or initialize an empty map if it doesn't exist
      Map<String, dynamic> mappings = foodData['mappings'] ?? {};

      // Generate a new mapping name (e.g., number1, number2, ...)
      int mappingNumber = (foodData['latestMappingNumber'] ?? 0) + 1;

      // Generate a new mapping name (e.g., number1, number2, ...)
      String mappingName = 'number$mappingNumber';

      // Create a new mapping with the specified data
      Map<String, dynamic> newMapping = {
        'foodImage': foodImage,
        'menu': menu,
        'memo': memo,
        'timestamp': date,
      };

      // Add the new mapping to the mappings map
      mappings[mappingName] = newMapping;

      // Update the mappings field in the "Food" document
      foodData['mappings'] = mappings;

      foodData['latestMappingNumber'] = mappingNumber;
      foodData['date'] = date;

      // Update the "Food" document with the new mappings
      await userRef.collection('Food').doc(formattedDate).set(foodData);
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setInt('latestMappingNumber', latestMappingNumber);

      print('Successfully added mapping: $mappingName');
    } catch (e) {
      print('Error creating diet mapping: $e');
    }
  }
  Future<void> createTraineeMemo(String userDocumentName, String title, String text) async {
  try {
    // Get a reference to the user's document in the "trainee" collection using the provided document name
    DocumentReference userRef = FirebaseFirestore.instance.collection('trainee').doc(userDocumentName);

    // Get the current timestamp
    DateTime currentTime = DateTime.now();

    // Create a new memo with the specified data
    Map<String, dynamic> newMemo = {
      'title': title,
      'content': text,
      'date': currentTime,
    };

    // Add the new memo as a document under the "memo" collection
    await userRef.collection('memo').add(newMemo);

    print('Successfully added memo: $title');
  } catch (e) {
    print('Error creating trainee memo: $e');
  }
}

Future<void> updateTraineeMemo(String userDocumentName, String memoDocumentId, String newTitle, String newText) async {
  try {
    // Get a reference to the user's document in the "trainee" collection using the provided document name
    DocumentReference userRef = FirebaseFirestore.instance.collection('trainee').doc(userDocumentName);

    // Get the reference to the memo document within the "memo" collection
    DocumentReference memoRef = userRef.collection('memo').doc(memoDocumentId);

    // Get the current timestamp
    DateTime currentTime = DateTime.now();

    // Create updated memo data
    Map<String, dynamic> updatedMemo = {
      'title': newTitle,
      'content': newText,
      'date': currentTime,
    };

    // Update the memo with the new data
    await memoRef.update(updatedMemo);

    print('Successfully updated memo: $newTitle');
  } catch (e) {
    print('Error updating trainee memo: $e');
  }
}


  // Future<void> deleteMapping(
  //   String userUid,
  //   String formattedDate,
  //   String mappingName,
  // ) async {
  //   try {
  //     // Get a reference to the user's document in the "trainee" collection
  //     DocumentReference userRef =
  //         FirebaseFirestore.instance.collection('trainee').doc(userUid);

  //     // Get the user's "Food" document
  //     DocumentSnapshot<Map<String, dynamic>> foodDocSnapshot =
  //         await userRef.collection('Food').doc(formattedDate).get();
  //     Map<String, dynamic> foodData = foodDocSnapshot.data() ?? {};

  //     // Get the existing mappings or initialize an empty map if it doesn't exist
  //     Map<String, dynamic> mappings = foodData['mappings'] ?? {};

  //     // Remove the mapping to be deleted
  //     mappings.remove(mappingName);

  //     // Re-number the remaining mappings to ensure continuous numbering
  //     int newMappingNumber = 1;
  //     Map<String, dynamic> renumberedMappings = {};
  //     for (var oldMappingName in mappings.keys) {
  //       renumberedMappings['number$newMappingNumber'] =
  //           mappings[oldMappingName];
  //       newMappingNumber++;
  //     }

  //     // Update the mappings field in the "Food" document
  //     foodData['mappings'] = renumberedMappings;

  //     // Update the latest mapping number in the document
  //     foodData['latestMappingNumber'] = newMappingNumber - 1;

  //     // Update the "Food" document with the updated mappings and latest mapping number
  //     await userRef.collection('Food').doc(formattedDate).set(foodData);

  //     print('Successfully deleted mapping: $mappingName');
  //   } catch (e) {
  //     print('Error deleting diet mapping: $e');
  //   }
  // }
}
