import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/model/event.dart';
import 'package:final_project/model/my_user.dart';

class FirebaseUtils {
  //todo users collection
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromJsonFirestore(snapshot.data()!),
          toFirestore: (model, _) => model.toJsonFirestore(),
        );
  }

  static Future<void> addUserToFirestoreWithConverter(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    var querySnapShot = await getUsersCollection().doc(uId).get();
    return querySnapShot.data();
  }

  //////////////////////////////
  //todo Events
  //////////////////////////////
  static CollectionReference<Event> getEventCollection() {
    return FirebaseFirestore.instance
        .collection('Events')
        .withConverter<Event>(
          fromFirestore: (snapshot, _) =>
              Event.fromJsonFirestore(snapshot.data()!),
          toFirestore: (model, _) => model.toJsonFirestore(),
        );

    // Future<void> main() async {
    //   // Writes now take a Model as parameter instead of a Map
    //   await modelsRef.add(Model());
    //
    //   // Reads now return a Model instead of a Map
    //   final Model model = await modelsRef.doc('123').get().then((s) => s.data());
    // }
  }

  static Future<void> addEventToFirestoreWithConverter(Event event) {
    CollectionReference<Event> collectionRef = getEventCollection();
    DocumentReference<Event> docRef = collectionRef.doc();
    event.id = docRef.id;
    return docRef.set(event);
    //اختصار
    // DocumentReference<Event> eventRef = FirebaseFirestore.instance
    //     .collection(Event.collectionName)
    //     .withConverter(
    //   fromFirestore: (snapshot, _) =>
    //       Event.fromJsonFirestore(snapshot.data()!),
    //   toFirestore: (model, _) => model.toJsonFirestore(),
    // ).doc();
    // event.id = eventRef.id;
    // return eventRef.set(event);
  }

  //todo read data =>one time data

  // void getAllEvent1() async {
  //   QuerySnapshot<Event> querySnapshot =
  //   await FirebaseUtils.getEventCollection().get();
  //   eventList = querySnapshot.docs.map((doc) {
  //     return doc.data();
  //   }).toList();
  //   setState(() {});
  // }
  //todo read data =>real time data
  static Stream<List<Event>> getAllEvent() {
    return FirebaseUtils.getEventCollection()
        .orderBy('eventDate')
        .snapshots()
        .map((querySnapShot) {
          return querySnapShot.docs.map((doc) {
            return doc.data();
          }).toList();
        });
  }

  //todo read orderd data =>real time data
  static Stream<List<Event>> getFilterEvents({required int selectedIndex}) {
    return FirebaseUtils.getEventCollection()
        .where('eventCategoryIndex', isEqualTo: selectedIndex)
        .orderBy('eventDate')
        .snapshots()
        .map((querySnapShot) {
          return querySnapShot.docs.map((doc) {
            return doc.data();
          }).toList();
        });
  }

  static Future<void> updateIsFavourite(Event event) {
    return getEventCollection().doc(event.id).update({
      'isFavorite': !event.isFavorite,
    });
  }

  static Stream<List<Event>> getAllFavouriteEvents() {
    return FirebaseUtils.getEventCollection()
        .where('isFavorite', isEqualTo: true)
        .orderBy('eventDate')
        .snapshots()
        .map((querySnapShot) {
          return querySnapShot.docs.map((doc) {
            return doc.data();
          }).toList();
        });
  }

  //خد بالك
  //WithMap >>.add(map);
  //WithConverter object >>.set(event);
  static addEventToFirestoreWithMap() {
    Map<String, dynamic> map = {'id': 42, 'ayman': 'ayman'};
    FirebaseFirestore.instance.collection('Events').add(map);
  }
}
