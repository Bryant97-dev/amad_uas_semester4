part of 'services.dart';

class ProductServices{
  //setup cloud firestore
   static FirebaseAuth auth = FirebaseAuth.instance;
   static CollectionReference assignmentCollection = FirebaseFirestore.instance.collection("assignment");
   static CollectionReference pinsCollection = FirebaseFirestore.instance.collection("pins");
   static DocumentReference assignmentDocument;

   //setup storage
   static Reference ref;
   static UploadTask uploadTask;
   static String imgUrl;

   static Future<bool> addProduct(Assignment assignment, PickedFile imgFile) async{
      await Firebase.initializeApp();
      assignmentDocument = await assignmentCollection.add({
         'assignId' : assignment.assignId,
         'assignName' : assignment.assignName,
         'assignCourse' : assignment.assignCourse,
         'assignDeadline' : assignment.assignDeadline,
         'assignDesc' : assignment.assignDesc,
         'assignImage' : assignment.assignImage,
         'assignFile' : assignment.assignFile,
         'addBy':auth.currentUser.uid,
         'createdAt' : assignment.createdAt,
         'updatedAt' : assignment.updateAt,
      });
      if(assignmentDocument != null){
         ref = FirebaseStorage.instance.ref().child("images").child(assignmentDocument.id+"jpg");
         uploadTask = ref.putFile(File(imgFile.path));

         await uploadTask.whenComplete(()=>
            ref.getDownloadURL().then((value) => imgUrl = value,)
         );

         assignmentCollection.doc(assignmentDocument.id).update(
            {
               'assignId' : assignmentDocument.id,
               'assignImage' :imgUrl,
            }
         );

         return true;
      }else{
         return false;
      }
   }

   static Future<bool> deleteproduct(String id) async {
      bool hsl = true;
      bool hsp = true;
      await Firebase.initializeApp();
      await assignmentCollection.doc(id).delete().then((value) {
         hsl = true;
      }).catchError((onError){
         hsl = false;
      });

      if(hsl == true){
         await pinsCollection.doc(id).delete().then((value) {
            hsp = true;
         }).catchError((onError){
            hsp = false;
         });
      }
      return hsl;
   }

   static Future<bool> updateproduct(Assignment assignment,PickedFile imgFile, String id) async {
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
      if(imgFile != null) {
         ref = FirebaseStorage.instance.ref().child("images").child(id + "jpg");
         uploadTask = ref.putFile(File(imgFile.path));

         await uploadTask.whenComplete(() =>
             ref.getDownloadURL().then((value) => imgUrl = value,)
         );

         await assignmentCollection.doc(id).update(
             {
                'assignImage': imgUrl,
             }
         );
      }

      return hsl;
   }

}