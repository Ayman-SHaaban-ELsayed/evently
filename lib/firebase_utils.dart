import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/model/event.dart';

class FirebaseUtils {
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

 static Future<void>  addEventToFirestoreWithConverter(Event event) {
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
//خد بالك
  //WithMap >>.add(map);
  //WithConverter object >>.set(event);
  static addEventToFirestoreWithMap() {
    Map<String, dynamic> map = {'id': 42, 'ayman': 'ayman'};
    FirebaseFirestore.instance.collection('Events').add(map);
  }
}
