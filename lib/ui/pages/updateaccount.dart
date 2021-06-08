part of "pages.dart";

class  UpdateAccount extends StatefulWidget {

  final String id;
final String name;
final String phone;
final String email;

const UpdateAccount(
{Key key,
  this.id,
  this.name,
  this.phone,
  this.email,
})
    : super(key: key);

@override
  _UpdateAccountState createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlPhone = TextEditingController();


  @override
  void initState() {
    ctrlName.text = widget.name;
    ctrlPhone.text = widget.phone;
    super.initState();
  }

  @override
  void dispose(){
    ctrlName.dispose();
    ctrlPhone.dispose();

    super.dispose();
  }

  void clearForm(){
    ctrlName.clear();
    ctrlPhone.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Account"),
      ),
      resizeToAvoidBottomInset: false ,
      body: Container(
        width : double.infinity,
        height : double.infinity,
        child: Stack(
            children:[
              ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    Form(
                      key:_formKey,
                      child:  Column(
                        children: [
                          SizedBox(height:24),
                          TextFormField(
                            controller:  ctrlName,
                            keyboardType:  TextInputType.name,
                            decoration: InputDecoration(
                              labelText:"User Name",
                              prefixIcon: Icon(Icons.label),
                              //  border: OutlineInputBorder(),
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value){
                              if(value.isEmpty){
                                return"Please fill the field!";
                              }else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(height:24),
                          TextFormField(
                            controller:  ctrlPhone,
                            keyboardType:  TextInputType.name,
                            //maxLines: 3,
                            decoration: InputDecoration(
                              labelText:"User Phone",
                              prefixIcon: Icon(Icons.description),
                              //  border: OutlineInputBorder(),
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value){
                              if(value.isEmpty){
                                return"Please fill the field!";
                              }else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(height:24),

                          ElevatedButton.icon(
                              onPressed: () async {
                                if(_formKey.currentState.validate()){
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Users users = new Users(widget.id, ctrlName.text, ctrlPhone.text, widget.email, "", "", "");
                                  await AuthServices.updateaccount(users, widget.id).then((value){
                                    if(value == true){
                                      Fluttertoast.showToast(msg: "Update Account succesfully !",
                                          backgroundColor: Colors.green);
                                      clearForm();
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }else{
                                      ActivityServices.showToast("Add Account failed", Colors.red);
                                    }
                                  });
                                }else{
                                  ActivityServices.showToast("Please check form fields !", Colors.red);
                                  // bisa dikosongkan saja
                                  //Fluttertoast.showToast(msg: "Please check the fields !",backgroundColor: Colors.red);
                                }
                              },
                              icon : Icon(Icons.save),
                              label: Text("Update Account"),
                              style : ElevatedButton.styleFrom(
                                onPrimary: Colors.white,
                                primary: Colors.deepPurple,
                                elevation: 4,
                              )
                          ),

                        ],
                      ),
                    ),
                  ]
              ),
              isLoading == true
                  ? ActivityServices.loadings()
                  : Container()
            ]
        ),
      ),
    );
  }
}
