// replace FirebaseCRUD with your feature name
// eg. these apis are related to fetching of profile data
// then class name - ProfileApiService

// server - firebase
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../api_layer/api_response.dart';
import 'models/model_name.dart';

class FirebaseCRUDApiService {
  // create apis
  static Future<ApiResponse<bool>> createDoc() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc('doc_name')
          .set({
        // model.toMap()
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
  static Future<ApiResponse<ModelName>> readDoc() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('collection_name')
          .doc('doc_name')
          .get();

      ModelName modelName =
          ModelName.fromMap(documentSnapshot.data() as Map<String, dynamic>);
      return ApiResponse(data: modelName);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  static Future<ApiResponse<List<ModelName>>> readCollection() async {
    try {
      List<ModelName> models = [];
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('collection_name').get();

      for (var i = 0; i < querySnapshot.docs.length; i++) {
        models.add(ModelName.fromMap(
            querySnapshot.docs[i].data() as Map<String, dynamic>));
      }
      return ApiResponse(data: models);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  // update apis
  static Future<ApiResponse<bool>> updateDoc(ModelName updatedModel) async {
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
  static Future<ApiResponse<bool>> deleteDoc() async {
    try {
      await FirebaseFirestore.instance
          .collection('collection_name')
          .doc('doc_name')
          .delete();

      return const ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
