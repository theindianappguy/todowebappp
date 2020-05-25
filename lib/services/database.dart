import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices{
  
  uploadUserInfo(String userId, Map userMap){
    Firestore.instance.collection("users")
        .document(userId)
        .setData(userMap)
        .catchError((e){
          print(e.toString());
    });
  }

  updateTask(String userId, Map taskMap, String documentId){
    Firestore.instance.collection("users")
        .document(userId)
        .collection("tasks")
        .document(documentId)
        .setData(taskMap, merge: true);
  }

  createTask(String userId, Map taskMap){
    Firestore.instance.collection("users")
        .document(userId)
        .collection("tasks")
        .add(taskMap);
  }

  getTasks(String userId) async {
    return await Firestore.instance.collection("users")
        .document(userId)
        .collection("tasks")
        .snapshots();
  }

  deleteTask(String userId,String documentId){
    Firestore.instance.collection("users")
        .document(userId)
        .collection("tasks")
        .document(documentId)
        .delete()
        .catchError((e){
          print(e.toString());
        });
  }
  
}