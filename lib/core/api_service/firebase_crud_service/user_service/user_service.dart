// replace FirebaseCRUD with your feature name
// eg. these apis are related to fetching of profile data
// then class name - ProfileApiService

// server - firebase
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import '../../../../main.dart';
import '../../../api_layer/api_response.dart';
import 'models/user_model.dart';

class UserApiService {
  // create apis
  static Future<ApiResponse<bool>> createDoc(UserModel user) async {
    try {
      final res = await dio
          .postUri(Uri.parse('https://money-trackey.onrender.com/user'), data: {
        'name': user.name,
        'email': user.email,
        'photoUrl': user.photoUrl,
        'stipendTotal': user.stipendTotal,
        'allowanceTotal': user.allowanceTotal,
        'stockTotal': user.stockTotal,
      });

      final token = res.headers.value('Authorization');
      final id = res.data['data']['id'];


      sharedPref.setString('token', token ?? '');
      sharedPref.setString('id', id ?? '');

      log(res.data.toString());

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
      final token = sharedPref.getString('token');

      final res = await dio.getUri(
        Uri.parse('https://money-trackey.onrender.com/user/$uid'),
        options: Options(headers: {'Authorization': 'Bearer ${token ?? ''}'}),
      );

      UserModel user = UserModel.fromMap(res.data['data']['user'] as Map<String, dynamic>);
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
      await FirebaseFirestore.instance.collection('users').doc(uid).delete();

      return const ApiResponse(data: true);
    } catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
