import 'package:flutter/material.dart';
import 'package:todowebappp/helper_functions/helper_functions.dart';
import 'package:todowebappp/services/database.dart';
import 'package:todowebappp/widgets/widget.dart';

class Home extends StatefulWidget {
  String username;
  final String userEmail;
  Home({this.username, this.userEmail});

  @override
  _HomeState createState() => _HomeState();
}

String uId = "gnpH1r191xOYLMIsIZgvxNSx5X53";

class _HomeState extends State<Home> {

  Stream taskStream;

  DatabaseServices databaseServices = new DatabaseServices();

  String date;
  TextEditingController taskEdittingControler = new TextEditingController();

  @override
  void initState() {

    var now = DateTime.now();
    date = "${HelperFunctions.getWeek(now.weekday)} ${HelperFunctions.getYear(now.month)} ${now.day}";

    databaseServices.getTasks(uId).then((val){

      taskStream = val;
      setState(() {});

    });

    super.initState();
  }

  Widget taskList(){

    return StreamBuilder(
      stream: taskStream,
      builder: (context, snapshot){
        return snapshot.hasData ?
        ListView.builder(
          padding: EdgeInsets.only(top: 16),
          itemCount: snapshot.data.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index){
              return TaskTile(
                snapshot.data.documents[index].data["isCompleted"],
                snapshot.data.documents[index].data["task"],
                snapshot.data.documents[index].documentID,
              );
            }) : Container();
      },
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets().mainAppar(),
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 32),
            width: 600,
            child: Column(
              children: [
              Text("My Day", style: TextStyle(
                fontSize: 18,
              ),),
              Text("$date"),
                Row(
                  children: [
                  Expanded(
                    child: TextField(
                      controller: taskEdittingControler,
                      decoration: InputDecoration(
                        hintText: "task"
                      ),
                      onChanged: (val){
                       // taskEdittingControler.text = val;
                        setState(() {

                        });
                      },
                    ),
                  ),
                  SizedBox(width: 6,),
                  taskEdittingControler.text.isNotEmpty ?
                  GestureDetector(
                    onTap: (){

                      Map<String, dynamic> taskMap = {
                        "task" : taskEdittingControler.text,
                        "isCompleted" : false
                      };

                      databaseServices.createTask(uId,taskMap);
                      taskEdittingControler.text = "";
                    },
                      child: Container(
                        padding: EdgeInsets
                          .symmetric(horizontal: 12, vertical: 5),
                          child: Text("ADD"))) : Container()
                ],),

                taskList()
            ],),
          ),
        ),
      ),
    );
  }
}

class TaskTile extends StatefulWidget {
  final bool isCompleted;
  final String task;
  final String documentId;
  TaskTile(this.isCompleted, this.task, this.documentId);

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: (){

              Map<String,dynamic> taskMap = {
                "isCompleted" : !widget.isCompleted
              };

              DatabaseServices().updateTask(uId, taskMap, widget.documentId);
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black87, width: 1),
                borderRadius: BorderRadius.circular(30)
              ),
              child:
              widget.isCompleted ?
              Icon(Icons.check, color: Colors.green,) : Container(),
            ),
          ),

          SizedBox(width: 8,),
          Text(
            widget.task,
            style: TextStyle(
              color: widget.isCompleted ? Colors.black87 :
                  Colors.black87.withOpacity(0.7) ,
              fontSize: 17,
              decoration: widget.isCompleted ?
                  TextDecoration.lineThrough :
                  TextDecoration.none
            ),
          ),

          Spacer(),

          GestureDetector(
            onTap: (){
              DatabaseServices().deleteTask(uId, widget.documentId);
            },
            child: Icon(
              Icons.close, size: 13, color: Colors.black87.withOpacity(0.7)
            ),
          )
        ],
      ),
    );
  }
}

