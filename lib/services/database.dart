import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');
  final String? uid;

  DatabaseService({this.uid});

  //string variables are easier to render to the screen
  Future updateUserData(String sugars,String name,int strength) async{
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
  });
  }

  //brew list from snapshot
  List<Brew> _BrewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Brew(
        name: doc.get('name') ?? '',
        strength: doc.get('strength') ?? 0,
        sugars: doc.get('sugars') ?? '0',
      );
    }).toList();
  }

  // userData frpm snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.get('name'),
      sugars: snapshot.get('sugars'),
      strength: snapshot.get('strength'),
    );
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
    .map(_BrewListFromSnapshot);
  }

  // get user doc stream

  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots()
            .map(_userDataFromSnapshot);
  }

}