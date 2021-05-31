part of 'pages.dart';

class Login extends StatefulWidget{
  static const String routeName = "/login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


  //memberikan identitas atau nama terhadap sebuah fungsi form
  final _formKey = GlobalKey<FormState>();
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      /* appBar: AppBar(
         title:Text('login'),
         centerTitle : true,
         elevation : 0,
     ),*/
     resizeToAvoidBottomInset:  false,
     body:  Container(
       width: double.infinity,
       height: double.infinity,
       padding:  EdgeInsets.all(24),
       child: Stack(
         children: [
           ListView(
             children: [
               Form(
                 key:_formKey,
                 child: Column(
                   children: [
                     Image.asset("assets/images/logo.png", height: 300
                     ),
                     SizedBox(height :24),
                     TextFormField(
                       controller:  ctrlEmail,
                       keyboardType:  TextInputType.emailAddress,
                       decoration: InputDecoration(
                         labelText:"Email",
                         prefixIcon: Icon(Icons.mail_outline_rounded),
                         border: OutlineInputBorder(),
                       ),
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                       validator: (value){
                         if(value.isEmpty){
                           return"Please fill the field!";
                         }else{
                           if(!EmailValidator.validate(value)){
                             return "Email is not valid !";
                           }else{
                             return null;
                           }
                         }
                       },
                     ),
                     SizedBox(height:24),
                     TextFormField(
                       controller:  ctrlPassword,
                      obscureText: isVisible,
                       decoration: InputDecoration(
                         labelText:"Password",
                         prefixIcon: Icon(Icons.vpn_key),
                         border: OutlineInputBorder(),
                         suffixIcon: new GestureDetector(
                           onTap: () {
                             setState(() {
                              isVisible = !isVisible;
                             });
                           },
                           child: Icon(
                             isVisible ?
                              Icons.visibility :
                              Icons.visibility_off
                           ),
                         ),
                       ),
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                       validator: (value){
                         return value.length < 6 ?
                             "Password must have at least 6 characters !"
                             : null ;
                       },
                     ),
                     SizedBox(height: 24),
                     ElevatedButton.icon(
                         onPressed: () async{
                           if(_formKey.currentState.validate()){
                             setState(() {
                               isLoading = true;
                             });
                             await AuthServices.signIn(ctrlEmail.text, ctrlPassword.text).then((value) {
                                  if(value == "success"){
                                    setState(() {
                                      isLoading = false;
                                    });
                                    ActivityServices.showToast("Login Success", Colors.green);
                                    Navigator.pushReplacementNamed(context, MainMenu.routeName);
                                  }else{
                                    setState(() {
                                      isLoading =false;
                                    });
                                    ActivityServices.showToast(value, Colors.red);
                                  }
                             });
                             //melanjutkan ketahap berikutnya
                             //replacement name di replace , pushedname ditumpuk ada tombol back
                             //vigator.pushNamed(context, MainMenu.routeName);
                           }else{
                             // bisa dikosongkan saja
                             Fluttertoast.showToast(msg: "Please check the fields !",backgroundColor: Colors.red);
                           }
                         },
                       icon : Icon(Icons.login_rounded),
                       label: Text("Login"),
                       style : ElevatedButton.styleFrom(
                         primary : Colors.deepPurple,
                         onPrimary: Colors.white,
                         elevation: 4,
                       )
                     ),
                     SizedBox(height: 24),
                     GestureDetector(
                       onTap :(){
                         Navigator.pushReplacementNamed(context, Register.routeName);
                       },
                       child :Text("Not registered yet",
                       style : TextStyle(color: Colors.deepPurple,
                       fontSize : 16
                       ),
                     ),
                     )],
                 ),
               )
             ],
           ),
           isLoading == true
           ? ActivityServices.loadings() : Container()
        ],
       )
     ),
   );
  }
}
