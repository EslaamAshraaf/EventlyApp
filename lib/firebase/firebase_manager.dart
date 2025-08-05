import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:evently/models/task_model.dart';
import 'package:evently/models/user_model.dart';

class FirebaseManager {
  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (model, _) {
        return model.toJson();
      },
    );
  }

  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (model, _) {
        return model.toJson();
      },
    );
  }

  static Future<void> createEvent(TaskModel model) {
    var docRef = getTasksCollection().doc();
    model.id = docRef.id;
    return docRef.set(model);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(String category) {
    if (category == "All") {
      return getTasksCollection()
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      // .orderBy("date") // Uncomment after confirming all documents have "date"
          .snapshots();
    }
    return getTasksCollection()
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("category", isEqualTo: category)
    // .orderBy("date") // Uncomment after confirming all documents have "date"
        .snapshots();
  }

  static createAccount(UserModel user) {
    var docRef = getUsersCollection().doc(user.id);
    docRef.set(user);
  }

  static Future<UserModel?> readUser() async {
    DocumentSnapshot<UserModel> docRef = await getUsersCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return docRef.data();
  }

  static login(
      String emailAddress,
      String password,
      Function onSuccess,
      Function onError,
      ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(e.message);

      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  static signUp(
      String email,
      String password,
      String phone,
      String userName,
      Function onSuccess,
      Function onError,
      ) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      credential.user!.sendEmailVerification();
      UserModel userModel = UserModel(
        credential.user!.uid,
        userName,
        email,
        phone,
      );
      createAccount(userModel);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError('The password provided is too weak.');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onError('The account already exists for that email.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
