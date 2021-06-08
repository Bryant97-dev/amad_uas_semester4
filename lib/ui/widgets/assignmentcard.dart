part of 'widgets.dart';


class AssignmentCard extends StatefulWidget {

  final Assignment assignment;
  AssignmentCard({this.assignment});


  @override
  _AssignmentCardState createState() => _AssignmentCardState();
}

class _AssignmentCardState extends State<AssignmentCard> {
  bool isLoading = false;
  CollectionReference assignmentCollection = FirebaseFirestore.instance.collection("assignment");
  @override

  Widget build(BuildContext context) {
    Assignment assignment = widget.assignment;
    if(assignment == null){
      return Container();
    }else {
      return Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0)
        ),
        margin: EdgeInsets.fromLTRB(8, 8, 0, 8),
        child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 24.8,
                    backgroundImage: NetworkImage(assignment.assignImage),
                  ),
                  title: Text(
                    assignment.assignName, style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,),
                    maxLines: 1,
                    softWrap: true,
                  ),
                  subtitle: Text(
                    assignment.assignDeadline, style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,),
                    maxLines: 1,
                    softWrap: true,
                  ),
                  trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        /*IconButton(
                icon: Icon(
                    CupertinoIcons.trash_circle
                    ,color: Colors.red,
                ),
                onPressed: (){

                },
              ),*/
                        IconButton(
                          icon: Icon(Icons.more_horiz_rounded,
                            color: Colors.blue,),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return Container(
                                    //alignment: Alignment.bottomCenter,
                                     width: double.infinity,
                                      height: 1000,
                                     // padding: EdgeInsets.all(0),
                                    child: Stack(
                                        children:<Widget>[
                                          Container(
                                            padding: EdgeInsets.all(20),
                                            child: ListView(
                                              // mainAxisAlignment: MainAxisAlignment
                                              //    .spaceEvenly,
                                              children: [
                                                Column(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(20),
                                                      child: Image(
                                                        height: 300,
                                                        image:NetworkImage(assignment.assignImage),
                                                      ),
                                                    ),
                                                    SizedBox(height:24,),
                                                    Row(
                                                      children: [
                                                        Icon(CupertinoIcons.news_solid),
                                                        Text("    "+assignment.assignName, textAlign:TextAlign.center,),
                                                      ],
                                                    ),
                                                    SizedBox(height:24),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.description),
                                                        Text("    "+assignment.assignCourse),
                                                      ],
                                                    ),
                                                    SizedBox(height:24),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.lock_clock),
                                                        Text("    "+assignment.assignDeadline),
                                                      ],
                                                    ),
                                                    SizedBox(height:24),
                                                    Row(
                                                      children: [
                                                        Flexible(
                                                           child:Container(
                                                             alignment:Alignment.center,
                                                               child: Column(
                                                                 children: [
                                                                   Text("Description :",textAlign: TextAlign.left ,style: TextStyle(fontWeight: FontWeight.bold),),
                                                                   SizedBox(height :10),
                                                                   Text(assignment.assignDesc),
                                                                 ],
                                                               )
                                                            )
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(height:200),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),

                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Row(
                                             mainAxisAlignment: MainAxisAlignment
                                                 .spaceEvenly,
                                              children: [
                                                ElevatedButton.icon(
                                                  icon: Icon(CupertinoIcons
                                                      .pin_fill),
                                                  label: Text("Pins data"),
                                                  onPressed: ()async {
                                                      setState(() {
                                                        isLoading = true;
                                                      });
                                                      Pins pins = Pins("",assignment.assignName,assignment.assignCourse,
                                                          assignment.assignDeadline,assignment.assignDesc,assignment.assignImage,"",FirebaseAuth.instance.currentUser.uid,"","");
                                                      await PinsServices.addPins(pins).then((value){
                                                        if(value == true){
                                                          ActivityServices.showToast("pins data succes", Colors.green);
                                                          setState(() {
                                                            isLoading = false;
                                                          });
                                                        }else{
                                                          ActivityServices.showToast("pins data failed", Colors.red);
                                                        }
                                                      });
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      onPrimary: Colors.white,
                                                      primary: Colors.deepPurple
                                                  ),
                                                ),
                                                ElevatedButton.icon(
                                                  icon: Icon(CupertinoIcons.pencil),
                                                  label: Text("Edit data"),
                                                  onPressed: () async{
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => UpdateData(
                                                                assignId: assignment.assignId,
                                                                assignName: assignment.assignName,
                                                                assignCourse: assignment.assignCourse,
                                                                assignDeadline: assignment.assignDeadline,
                                                                assignDesc:assignment.assignDesc,
                                                            )));
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      onPrimary: Colors.white,
                                                      primary: Colors.deepPurple
                                                  ),
                                                ),
                                                ElevatedButton.icon(
                                                  icon: Icon(
                                                      CupertinoIcons.trash_fill),
                                                  label: Text("Delete data"),
                                                  onPressed: () async{
                                                    bool result = await ProductServices.deleteproduct(assignment.assignId);
                                                    if(result){
                                                      ActivityServices.showToast("delete data succes", Colors.green);
                                                    }else{
                                                      ActivityServices.showToast("Delete data Succces", Colors.red);
                                                    }
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      onPrimary: Colors.white,
                                                      primary: Colors.deepPurple
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]
                                    ),
                                  );
                                }
                            );
                          },
                        ),
                      ]
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                        child:Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Colors.deepPurple,
                                width: 1,
                              ),
                            ),
                          ),
                            alignment:Alignment.center,
                            child: Column(
                              children: [
                                Text(assignment.assignCourse, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),),
                              ],
                            )
                        )
                    )
                  ],
                ),
               // Text("Course : "+assignment.assignCourse, textAlign: TextAlign.center)
              ],
            )

        ),
      );
    }

  }
}
