/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// const {onRequest} = require("firebase-functions/v2/https");
// const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.createFoodIndex = functions.firestore
  .document('trainee/{userUid}')
  .onCreate(async (snapshot, context) => {
    const userUid = context.params.userUid;

    try {
      const indexDefinition = {
        fields: [
          {
            fieldPath: '__name__', // Order based on document ID (date)
            direction: 'DESCENDING',
          },
        ],
      };

      await admin.firestore().collection('trainee').doc(userUid).collection('Food').createIndex(indexDefinition);

      console.log(`Index created for user: ${userUid}`);
    } catch (error) {
      console.error('Error creating index:', error);
    }
  });