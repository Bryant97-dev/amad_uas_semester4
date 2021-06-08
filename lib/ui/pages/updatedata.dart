part of 'pages.dart';


class UpdateData extends StatefulWidget {
  final String assignId;
  final String assignName;
  final String assignCourse;
  final String assignDeadline;
  final String assignDesc;

  const UpdateData(
      {Key key,
        this.assignId,
        this.assignName,
        this.assignDesc,
        this.assignDeadline,
        this.assignCourse,
      })
      : super(key: key);


  @override
  _UpdateDataState createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlCourse = TextEditingController();
  final ctrlDeadline = TextEditingController();
  final ctrlDesc = TextEditingController();
  final ctrlPassword = TextEditingController();
  PickedFile imageFile;
  final ImagePicker  imagePicker = ImagePicker();


  @override
  void initState() {
    ctrlName.text = widget.assignName;
    ctrlCourse.text = widget.assignCourse;
    ctrlDeadline.text = widget.assignDeadline;
    ctrlDesc.text = widget.assignDesc;
    super.initState();
  }

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
                    onPrimary: Colors.white,
                    primary: Colors.deepPurple,
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
                    onPrimary: Colors.white,
                    primary: Colors.deepPurple,
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
        title: Text("Update Data"),
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
                            controller:  ctrlCourse,
                            keyboardType:  TextInputType.name,
                            //maxLines: 3,
                            decoration: InputDecoration(
                              labelText:"Assignment class",
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
                          TextFormField(
                            controller:  ctrlDeadline,
                            keyboardType:  TextInputType.name,
                            decoration: InputDecoration(
                              labelText:"Deadline Assignment",
                              prefixIcon: Icon(Icons.lock_clock),
                              // border: OutlineInputBorder(),
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
                              //border: OutlineInputBorder(),
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
                          Column(
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
                          Column(
                            children :[
                              ElevatedButton.icon(
                                onPressed: (){
                                  showFileDialog(context);
                                  // chooseFile();
                                },
                                icon: Icon(Icons.photo_camera),
                                label:Text ("Ulang foto"),
                                style: ElevatedButton.styleFrom(
                                    onPrimary: Colors.white,
                                    primary: Colors.deepPurple
                                ),
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
                                if(_formKey.currentState.validate()){
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Assignment assignment = Assignment(widget.assignId,ctrlName.text,ctrlCourse.text,
                                      ctrlDeadline.text,ctrlDesc.text,"","",FirebaseAuth.instance.currentUser.uid,"",""
                                  );
                                  await ProductServices.updateproduct(assignment, imageFile, widget.assignId).then((value){
                                    if(value == true){
                                      Fluttertoast.showToast(msg: "Update Assignment succesfully !",
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
                              label: Text("Update Assignment"),
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
