part of 'pages.dart';

class ListData extends StatefulWidget {
  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  CollectionReference assignmentCollection = FirebaseFirestore.instance.collection("assignment");

  Widget buildBody(){
    return Container(
        width: double.infinity,
        height: double.infinity,
        //mendeteksi perubahan data secara otomatis
        child : StreamBuilder<QuerySnapshot>(
          stream: assignmentCollection.snapshots(),
          builder : (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError){
              return Text("Failed to load data!");
            }
            if (snapshot.connectionState == ConnectionState.waiting){
              return ActivityServices.loadings();
            }

            return new ListView(
              children : snapshot.data.docs.map((DocumentSnapshot doc){
                Assignment assignment;
                if (doc.data()['addBy'] == FirebaseAuth.instance.currentUser.uid){
                assignment = new Assignment(
                  doc.data()['assignId'],
                  doc.data()['assignName'],
                  doc.data()['assignCourse'],
                  doc.data()['assignDeadline'],
                  doc.data()['assignDesc'],
                  doc.data()['assignImage'],
                  doc.data()['assignFile'],
                  doc.data()['addBy'],
                  doc.data()['createdAt'],
                  doc.data()['updateAt'],
                );
                } else {
                  assignment = null;
                }
                return AssignmentCard(assignment:assignment);
              }).toList(),
            );
          },
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Data"),
       // centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: buildBody(),
    );
  }
}
