import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection() => FirebaseFirestore
      .instance
      .collection(Task.collectionName)
      .withConverter<Task>(
        fromFirestore: (docSnapshot, _) => Task.fromJson(docSnapshot.data()!),
        toFirestore: (task, _) => task.toJson(),
      );

  static Future<List<Task>> getAllTasks() async {
    CollectionReference<Task> tasksCollection = getTasksCollection();
    QuerySnapshot<Task> querySnapshot = await tasksCollection.get();
    return querySnapshot.docs
        .map(
          (docSnapShot) => docSnapShot.data(),
        )
        .toList();
  }

  static Future<void> addTaskToFirestore(Task task) async {
    CollectionReference<Task> tasksCollection =
        getTasksCollection(); // Create collection
    DocumentReference<Task> docRef = tasksCollection.doc(); // create document
    task.id = docRef.id; // create auto id
    return docRef.set(task);
  }

  static Future<void> deleteTaskFromFirestore(String taskId) async {
    CollectionReference<Task> tasksCollection = getTasksCollection();
    return tasksCollection.doc(taskId).delete();
  }


  static Future<void> updateTaskInFireStore(String taskId, Map<String, dynamic> task) async {
    CollectionReference<Task> tasksCollection = getTasksCollection();
    return tasksCollection.doc(taskId).update(task);
  }
}
