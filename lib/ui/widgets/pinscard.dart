part of 'widgets.dart';

class PinsCard extends StatefulWidget {
  final Pins pins;
  PinsCard({this.pins});

  @override
  _PinsCardState createState() => _PinsCardState();
}

class _PinsCardState extends State<PinsCard> {
  CollectionReference pinsCollection = FirebaseFirestore.instance.collection("pins");
  @override
  Widget build(BuildContext context) {
    Pins pins = widget.pins;
    if(pins == null){
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
                    backgroundImage: NetworkImage(pins.pinImage),
                  ),
                  title: Text(
                    pins.pinName, style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,),
                    maxLines: 1,
                    softWrap: true,
                  ),
                  subtitle: Text(
                    pins.pinDeadline, style: TextStyle(
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
                                                    Image.network(pins.pinImage, height: 300,),
                                                    SizedBox(height:24,),
                                                    Row(
                                                      children: [
                                                        Icon(CupertinoIcons.news_solid),
                                                        Text("    "+pins.pinName, textAlign:TextAlign.center,),
                                                      ],
                                                    ),
                                                    SizedBox(height:24),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.description),
                                                        Text("    "+pins.pinCourse),
                                                      ],
                                                    ),
                                                    SizedBox(height:24),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.lock_clock),
                                                        Text("    "+pins.pinDeadline),
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
                                                                    Text(pins.pinDesc),
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
                                                  icon: Icon(
                                                      CupertinoIcons.pin_slash),
                                                  label: Text("Unpins"),
                                                  onPressed: () async{
                                                    bool result = await PinsServices.deletepins(pins.pinId);
                                                    if(result){
                                                      ActivityServices.showToast("Unpin data success " , Colors.green);
                                                    }else{
                                                      ActivityServices.showToast("Unpin data failed", Colors.red);
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
                                Text(pins.pinCourse, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),),
                              ],
                            )
                        )
                    )
                  ],
                ),
              ],
            )
        ),
      );
    }

  }
}


