part of 'services.dart';

class PinsServices {
  //setup cloud firestore
  static FirebaseAuth auth = FirebaseAuth.instance;
  static CollectionReference pinsCollection = FirebaseFirestore.instance
      .collection("pins");
  static DocumentReference pinsDocument;

  //setup storage
  static Reference ref;
  static UploadTask uploadTask;
  static String imgUrl;

  static Future<bool> addPins(Pins pins, PickedFile imgFile) async {
    await Firebase.initializeApp();
    pinsDocument = await pinsCollection.add({
      'pinId': pins.pinId,
      'pinName': pins.pinName,
      'pinCourse': pins.pinCourse,
      'pinDeadline': pins.pinDeadline,
      'pinDesc': pins.pinDesc,
      'pinImage': pins.pinImage,
      'pinFile': pins.pinFile,
      'addBy': auth.currentUser.uid,
      'createdAt': pins.createdAt,
      'updatedAt': pins.updateAt,
    });
    if (pinsDocument != null) {
      ref = FirebaseStorage.instance.ref().child("images").child(
          pinsDocument.id + "jpg");
      uploadTask = ref.putFile(File(imgFile.path));

      await uploadTask.whenComplete(() =>
          ref.getDownloadURL().then((value) => imgUrl = value,)
      );

      pinsCollection.doc(pinsDocument.id).update(
          {
            'pinsId': pinsDocument.id,
            'pinsImage': imgUrl,
          }
      );

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deletepins(String id) async {
    bool hsl = true;
    await Firebase.initializeApp();
    await pinsCollection.doc(id).delete().then((value) {
      hsl = true;
    }).catchError((onError) {
      hsl = false;
    });
    return hsl;
  }

/*static Future<bool> updateproduct(Assignment assignment,PickedFile imgFile, String id) async {
    bool hsl = true;
    await Firebase.initializeApp();
    await assignmentCollection.doc(id).update({
      'assignId' : assignment.assignId,
      'assignName' : assignment.assignName,
      'assignCourse' : assignment.assignCourse,
      'assignDeadline' : assignment.assignDeadline,
      'assignDesc' : assignment.assignDesc,
      'updatedAt' : assignment.updateAt,

    }).then((value) {
      hsl = true;
    }).catchError((onError){
      hsl = false;
    });

    return hsl;
  }*/
}
