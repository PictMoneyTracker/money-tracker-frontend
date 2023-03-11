// replace FirebaseCRUD with your feature name
// eg. these apis are related to fetching of profile data
// then class name - ProfileApiService

// server - firebase
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../api_layer/api_response.dart';
import 'models/user_model.dart';



class UserApiService {
  // create apis
  static Future<ApiResponse<bool>> createDoc(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .set({
        // model.toMap()
        'id': user.id,
        'name': user.name,
        'email': user.email,
        'photoUrl': user.photoUrl,
        'stockTotal': user.stockTotal,
        'allowanceTotal': user.allowanceTotal,
        'stipendTotal': user.stipendTotal,
      });
      return const ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  static Future<ApiResponse<bool>> addDoc() async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        // model.toMap()

      });
      return const ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  // read apis
  static Future<ApiResponse<UserModel>> readDoc(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      UserModel user =
          UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
      return ApiResponse(data: user);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  static Future<ApiResponse<List<UserModel>>> readCollection() async {
    try {
      List<UserModel> models = [];
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      for (var i = 0; i < querySnapshot.docs.length; i++) {
        models.add(UserModel.fromMap(
            querySnapshot.docs[i].data() as Map<String, dynamic>));
      }
      return ApiResponse(data: models);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  // update apis
  static Future<ApiResponse<bool>> updateDoc(UserModel updatedModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(updatedModel.id)
          .update(updatedModel.toMap());

      return const ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  // delete apis
  static Future<ApiResponse<bool>> deleteDoc(String uid) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .delete();

      return const ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
