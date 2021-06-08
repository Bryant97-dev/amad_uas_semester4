part of 'pages.dart';

class ListPins extends StatefulWidget {
  @override
  _ListPinsState createState() => _ListPinsState();
}

class _ListPinsState extends State<ListPins> {
     CollectionReference pinsCollection = FirebaseFirestore.instance.collection("pins");

    Widget buildBody(){
      return Container(
          width: double.infinity,
          height: double.infinity,
          //mendeteksi perubahan data secara otomatis
          child : StreamBuilder<QuerySnapshot>(
            stream: pinsCollection.snapshots(),
            builder : (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.hasError){
                return Text("Failed to load data!");
              }
              if (snapshot.connectionState == ConnectionState.waiting){
                return ActivityServices.loadings();
              }

              return new ListView(
                children : snapshot.data.docs.map((DocumentSnapshot doc){
                  Pins pins;
                  if (doc.data()['addBy'] == FirebaseAuth.instance.currentUser.uid){
                    pins = new Pins(
                      doc.data()['pinId'],
                      doc.data()['pinName'],
                      doc.data()['pinCourse'],
                      doc.data()['pinDeadline'],
                      doc.data()['pinDesc'],
                      doc.data()['pinImage'],
                      doc.data()['pinFile'],
                      doc.data()['addBy'],
                      doc.data()['createdAt'],
                      doc.data()['updateAt'],
                    );
                  } else {
                    pins = null;
                  }
                  return PinsCard(pins:pins);
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
          title: Text("List Pins"),
          // centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        body: buildBody(),
      );
    }
  }

