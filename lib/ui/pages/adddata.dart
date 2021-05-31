part of 'pages.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlCourse = TextEditingController();
  final ctrlDeadline = TextEditingController();
  final ctrlDesc = TextEditingController();
  final ctrlPassword = TextEditingController();
  PickedFile imageFile;
  final ImagePicker  imagePicker = ImagePicker();

  Future chooseFolder(String type) async{
    FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if(result != null) {
      List<File> files = result.paths.map((path) => File(path)).toList();
    } else {
      // User canceled the picker
    }
  }

  Future chooseFile(String type) async{
    ImageSource imgSrc;
    if(type == "camera"){
      imgSrc= ImageSource.camera;
    }else{
      imgSrc= ImageSource.gallery;
    }

    final selectedImage = await imagePicker.getImage(
        source: imgSrc,
      imageQuality: 50,
    );
    setState(() {
      imageFile = selectedImage;
    });
  }

  void showFileDialog(BuildContext ctx){
    showDialog(
      context:  ctx,
      builder:  (ctx){
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Pick image from:"),
          actions:[
            ElevatedButton.icon(
              onPressed: (){
                chooseFile("camera");
              },
              icon:  Icon(Icons.camera),
              label: Text("camera"),
              style: ElevatedButton.styleFrom(
                elevation: 0
              ),
            ),
            ElevatedButton.icon(
              onPressed: (){
                chooseFile("gallery");
              },
              icon:  Icon(Icons.folder_outlined),
              label: Text("gallery"),
              style: ElevatedButton.styleFrom(
                  elevation: 0
              ),
            ),
          ],
        );
      }
    );
  }

  //mengurangi memori ketika mengetik
  @override
  void dispose(){
    ctrlName.dispose();
    ctrlCourse.dispose();
    ctrlDeadline.dispose();
    ctrlDesc.dispose();
    super.dispose();
  }

  void clearForm(){
    ctrlName.clear();
    ctrlCourse.clear();
    ctrlDeadline.clear();
    ctrlDesc.clear();
    setState(() {
      imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data"),
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
                          labelText:"Assignment Name",
                          prefixIcon: Icon(Icons.label),
                          border: OutlineInputBorder(),
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
                        controller:  ctrlCourse,
                        keyboardType:  TextInputType.name,
                        //maxLines: 3,
                        decoration: InputDecoration(
                          labelText:"Assignment class",
                          prefixIcon: Icon(Icons.description),
                          border: OutlineInputBorder(),
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
                        controller:  ctrlDeadline,
                        keyboardType:  TextInputType.name,
                        decoration: InputDecoration(
                          labelText:"Deadline Assignment",
                          prefixIcon: Icon(Icons.lock_clock),
                          border: OutlineInputBorder(),
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
                        controller:  ctrlDesc,
                        keyboardType:  TextInputType.name,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText:"Description Assignment",
                          prefixIcon: Icon(Icons.description),
                          border: OutlineInputBorder(),
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

                      imageFile == null ?
                      Row(
                        children :[
                          ElevatedButton.icon(
                            onPressed: (){
                              showFileDialog(context);
                             // chooseFile();
                            },
                            icon: Icon(Icons.photo_camera),
                            label:Text ("Ambil foto"),
                            style: ElevatedButton.styleFrom(
                                onPrimary: Colors.white,
                                primary: Colors.deepPurple
                            ),
                          ),
                          SizedBox(height:16),
                          Text("file tidak ditemukan.")
                        ],
                      )
                      :
                      Row(
                        children :[
                          ElevatedButton.icon(
                            onPressed: (){
                              showFileDialog(context);
                               // chooseFile();
                            },
                            icon: Icon(Icons.photo_camera),
                            label:Text ("Ulang foto"),
                          ),
                          SizedBox(height:16),
                          Semantics(
                            child : Image.file(File(imageFile.path),
                              width:100,
                              ),
                            )
                        ],
                      ),
                      SizedBox(height:24),
                      ElevatedButton.icon(
                          onPressed: () async {
                            if(_formKey.currentState.validate() && imageFile!=null){
                              setState(() {
                                isLoading = true;
                              });
                              Assignment assignment = Assignment("",ctrlName.text,ctrlCourse.text,
                                  ctrlDeadline.text,ctrlDesc.text,"","",FirebaseAuth.instance.currentUser.uid,"",""
                              );
                              await ProductServices.addProduct(assignment, imageFile).then((value){
                                if(value == true){
                                  Fluttertoast.showToast(msg: "Add Assignment succesfully !",
                                  backgroundColor: Colors.green);
                                  clearForm();
                                  setState(() {
                                    isLoading = false;
                                  });
                                }else{
                                  ActivityServices.showToast("Add Assignment failed", Colors.red);
                                }
                              });
                            }else{
                              ActivityServices.showToast("Please check form fields !", Colors.red);
                              // bisa dikosongkan saja
                              //Fluttertoast.showToast(msg: "Please check the fields !",backgroundColor: Colors.red);
                            }
                          },
                          icon : Icon(Icons.save),
                          label: Text("Add Assignment"),
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

