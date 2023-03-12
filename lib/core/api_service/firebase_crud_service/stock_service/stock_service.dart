// replace Stock with your feature name
// eg. these apis are related to fetching of profile data
// then class name - ProfileApiService

// server - firebase
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../api_layer/api_response.dart';
import 'models/stock_model.dart';

class StockApiService {
  // create apis
  static Future<ApiResponse<bool>> createDoc(
    StockModel stockModel,
    String uid,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('stocks')
          .doc(stockModel.id)
          .set({
        // model.toMap()
        'id': stockModel.id,
        'name': stockModel.name,
        'symbol': stockModel.symbol,
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
  static Future<ApiResponse<StockModel>> readDoc() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('collection_name')
          .doc('doc_name')
          .get();

      StockModel modelName =
          StockModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
      return ApiResponse(data: modelName);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  static Future<ApiResponse<List<StockModel>>> readCollection(
    String uid,
  ) async {
    try {
      List<StockModel> models = [];
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('stocks')
          .get();

      for (var i = 0; i < querySnapshot.docs.length; i++) {
        models.add(StockModel.fromMap(
            querySnapshot.docs[i].data() as Map<String, dynamic>));
      }
      return ApiResponse(data: models);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  // update apis
  static Future<ApiResponse<bool>> updateDoc(StockModel updatedModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('collection_name')
          .doc('doc_name')
          .update(updatedModel.toMap());

      return const ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  // delete apis
  static Future<ApiResponse<bool>> deleteDoc(String uid, String stockId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('stocks')
          .doc(stockId)
          .delete();

      return const ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
