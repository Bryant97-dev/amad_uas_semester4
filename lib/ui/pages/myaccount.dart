part of 'pages.dart';

class MyAccount extends StatefulWidget {


  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  //Users users;
  bool isLoading = false;

  Widget buildBody(){
    return Container(
        width: double.infinity,
        height: double.infinity,
        //mendeteksi perubahan data secara otomatis
        child : StreamBuilder<QuerySnapshot>(
          stream: userCollection.snapshots(),
          builder : (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError){
              return Text("Failed to load data!");
            }
            if (snapshot.connectionState == ConnectionState.waiting){
              return ActivityServices.loadings();
            }

            return new Stack(
              children : snapshot.data.docs.map((DocumentSnapshot doc){
                Users users;
                if (doc.data()['uid'] == FirebaseAuth.instance.currentUser.uid){
                  users = new Users(
                    doc.data()['uid'],
                    doc.data()['name'],
                    doc.data()['phone'],
                    doc.data()['email'],
                    doc.data()['password'],
                    doc.data()['createdAt'],
                    doc.data()['updateAt'],
                  );
                } else {
                  ActivityServices.showToast("gagal ehe"+FirebaseAuth.instance.currentUser.email, Colors.red);
                  users = null;
               }
                return AccountView(users:users);
              }).toList(),
            );
          },
        )
    );
  }


  @override
  Widget build(BuildContext context) {
  // Users users2 = widget.users2;
    return Scaffold(
      appBar: AppBar(
        title: Text("My Account"),
      ),
      body: buildBody(),
      /*body:Stack(
        children: [
          ListView(
            children: [
              Text("nama"+ users2.email),
              //SizedBox(height:24 ),
              Text("nama"),
            ],
          ),
           Container(
             alignment: Alignment.bottomCenter,
          child: ElevatedButton.icon(
              onPressed: () async{
                setState(() {
                  isLoading = true;
                });
                await AuthServices.signOut().then((value) {
                  if(value == true){
                    setState(() {
                      isLoading = false;
                    });
                    ActivityServices.showToast("Logout Success", Colors.green);
                    Navigator.pushReplacementNamed(context, Login.routeName);
                  }else{
                    setState(() {
                      isLoading = false;
                    });
                    ActivityServices.showToast("Logout Failed", Colors.red);
                  }
                });
                //melanjutkan ketahap berikutnya
                //replacement name di replace , pushedname ditumpuk ada tombol back
                //vigator.pushNamed(context, MainMenu.routeName);
              },
              icon : Icon(Icons.logout),
              label: Text("Logout"),
              style : ElevatedButton.styleFrom(
                primary : Colors.deepPurple,
                onPrimary: Colors.white,
                elevation: 4,
               // alignment: Alignment.bottomCenter,
              )
          ),
        ),
        ],
      ),*/

    );
  }
}
