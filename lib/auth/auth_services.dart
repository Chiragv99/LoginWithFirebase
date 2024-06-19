import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../uttils/appConstant.dart';

class AuthService {
  var userId = "";
  var email = "";
  var name = "";


  Future<String?> registration({required String email, required String password, required String name}) async{
     try{
       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
       userId = userCredential.user!.uid;
       addUserData(email,name);
       print("RegisterUser"+ userId.toString());
       return 'You are Registration successfully!';
     }on FirebaseAuthException catch (e){
       if (e.code == 'weak-password'){
         return 'The password provided is too weak.' ;
       }
       else if(e.code == 'email-already-in-use'){
         return 'The account already exists for that email.';
       }
       else{
         e.message;
       }
     }catch(e){
       print("Error" + e.toString());
       return e.toString();
     }
  }

  Future<String?> getRegistrationUserId () async{
    return userId;
  }
  Future<String?> loginWithFirebase(String userEmail,String userPassword) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: userEmail, password: userPassword);
      return 'Success';
    }on FirebaseAuthException catch (e){
      if (e.code == 'user-not-found'){
        return 'No user found for that email.';
      }
      else if(e.code == 'wrong-password'){
        return 'Your Email or Password is incorrect' ;
      }
      else{
        return e.message;
      }
    }catch (e){
      e.toString();
    }
  }


  void addUserData(String email, String name) async{

    String id = DateTime.now().microsecondsSinceEpoch.toString();
    final addUserDataRef = FirebaseDatabase.instance.ref(AppConstant.firebaseStorageUserData);
    addUserDataRef.child(userId).set({
      'id': id,
      'userId': id,
      'username': name,
      'email': email,
      'profileImageUrl': ''
    }).then((value) {
      print("Post"+ "User Addedd");
    }).onError((error, stackTrace) {
      print("Post"+ "Error");
    });
  }
}