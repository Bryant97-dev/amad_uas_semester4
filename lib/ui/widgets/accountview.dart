part of "widgets.dart";

class AccountView extends StatefulWidget {
  final Users users;
  AccountView({this.users});


  @override
  _AccountViewState createState() => _AccountViewState();
}


class _AccountViewState extends State<AccountView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Users users= widget.users;
    if(users == null){
      return Container();
   }else {
    //ActivityServices.showToast("acc show Success", Colors.green);
    return Stack(
      children: [
        Container(
          alignment: Alignment.topCenter,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            children: [
              Image.asset("assets/images/logo.png", height: 300
              ),
              ElevatedButton.icon(
                icon: Icon(CupertinoIcons.pencil),
                label: Text("Edit data"),
                onPressed: () async{
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateAccount(
                            id : users.uid,
                            name: users.name,
                            phone : users.phone,
                            email : users.email,
                          )));
                },
                style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: Colors.deepPurple
                ),
              ),
              SizedBox(height:15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person, color: Colors.black54,),
                  Text("  "+users.name, textAlign: TextAlign.center, style: TextStyle(fontSize: 24),),
                ],
              ),
              SizedBox(height:15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email, color: Colors.black54,),
                  Text("  "+users.email, textAlign: TextAlign.center, style: TextStyle(fontSize: 24),),
                ],
              ),
              SizedBox(height:15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone, color: Colors.black54,),
                  Text("  "+users.phone, textAlign: TextAlign.center, style: TextStyle(fontSize: 24),),
                ],
              ),
            ],
          ),
        ),

        Container(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton.icon(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await AuthServices.signOut().then((value) {
                  if (value == true) {
                    setState(() {
                      isLoading = false;
                    });
                    ActivityServices.showToast(
                        "Logout Success", Colors.green);
                    Navigator.pushReplacementNamed(
                        context, Login.routeName);
                  } else {
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
              icon: Icon(Icons.logout),
              label: Text("Logout"),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                elevation: 4,
                // alignment: Alignment.bottomCenter,
              )
          ),
        ),
      ],
    );

   }
  }
}
