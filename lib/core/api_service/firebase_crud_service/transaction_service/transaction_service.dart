// replace FirebaseCRUD with your feature name
// eg. these apis are related to fetching of profile data
// then class name - ProfileApiService

// server - firebase
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../api_layer/api_response.dart';
import 'models/transaction_model.dart';

class TransactionApiService {
  // create apis
  static Future<ApiResponse<bool>> createDoc(
      TransactionModel transactionModel, String uid) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('transactions')
          .doc(transactionModel.id)
          .set({
        // model.toMap()
        'id': transactionModel.id,
        'amount': transactionModel.amount,
        'category': transactionModel.category,
        'createdAt': transactionModel.createdAt,
        'description': transactionModel.description,
        'title': transactionModel.title,
        'spendFrom': transactionModel.spendFrom,
      });
      return const ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  static Future<ApiResponse<bool>> addDoc() async {
    try {
      await FirebaseFirestore.instance.collection('collection_name').add({
        // model.toMap()
      });
      return const ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  // read apis
  static Future<ApiResponse<TransactionModel>> readDoc(
      String uid, String txnId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('transactions')
          .doc(txnId)
          .get();

      TransactionModel transactionModel = TransactionModel.fromMap(
          documentSnapshot.data() as Map<String, dynamic>);
      return ApiResponse(data: transactionModel);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  static Future<ApiResponse<List<TransactionModel>>> readCollection(String uid) async {
    try {
      List<TransactionModel> models = [];
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).collection('transactions').get();

      for (var i = 0; i < querySnapshot.docs.length; i++) {
        models.add(TransactionModel.fromMap(
            querySnapshot.docs[i].data() as Map<String, dynamic>));
      }
      return ApiResponse(data: models);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  // update apis
  static Future<ApiResponse<bool>> updateDoc(
      TransactionModel updatedModel, String uid) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('transactions')
          .doc(updatedModel.id)
          .update(updatedModel.toMap());

      return const ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  // delete apis
  static Future<ApiResponse<bool>> deleteDoc(String uid, String txnId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('transactions')
          .doc(txnId)
          .delete();

      return const ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
