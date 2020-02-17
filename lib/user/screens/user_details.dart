
import 'package:etiqa_assessment/user/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:etiqa_assessment/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:etiqa_assessment/user/models/Todo.dart';
import 'package:etiqa_assessment/utils/formatters.dart';

class UserDetails extends StatefulWidget {

  final Todo todo;

  @override
  UserDetailsState createState() => UserDetailsState();
  UserDetails({Key key, @required this.todo}) : super(key: key);
}

class UserDetailsState extends State<UserDetails>{
  

  TextEditingController todoController = new TextEditingController();
  TextEditingController startDateController = new TextEditingController();
  TextEditingController endDateController = new TextEditingController();
  
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    final key = new GlobalKey<ScaffoldState>();

    if(widget.todo.isEdit){
        todoController.text = widget.todo.title;
        startDateController.text = Formatters.dateToFormat(widget.todo.startDate, DateFormat(Formatters.yyyyMMdd));
        endDateController.text = Formatters.dateToFormat(widget.todo.endDate, DateFormat(Formatters.yyyyMMdd));
    }
    
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: 
        Text((widget.todo.isEdit) ? "Edit To-Do" : "Add new To-Do List",
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      
      body: Column( 
          children: <Widget>[
            Expanded(
              flex: 9,
              child:Container(
            padding: EdgeInsets.all(20.0),
            child: 
              Table(
                          children: [
                              TableRow(
                                children: [
                                      TableCell(child: SizedBox(height: 24.0,)),
                                ]
                              ),
                              TableRow(
                                children: [
                                      TableCell(child: Text('To-Do Title', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey))),
                                ]
                              ),
                              TableRow(
                                children: [
                                      TableCell(child: SizedBox(height: 24.0,)),
                                ]
                              ),
                              TableRow(
                                children: [
                                      TableCell(
                                        child: 
                                        TextField(
                                            controller: todoController,
                                            maxLines: 8,
                                            decoration: 
                                              InputDecoration(hintText: "Please key in your To-Do title here", 
                                              border: OutlineInputBorder(),
                                              focusedBorder:OutlineInputBorder(
                                                borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                                              ),
                                            ),
                                            
                                        ),  
                                      ),
                                ]
                              ),
                              TableRow(
                                children: [
                                      TableCell(child: SizedBox(height: 24.0,)),
                                ]
                              ),
                              TableRow(
                                children: [
                                      TableCell(child: Text('Start Date', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey))),
                                ]
                              ),
                              TableRow(
                                children: [
                                      TableCell(child: SizedBox(height: 24.0,)),
                                ]
                              ),
                              TableRow(
                                children: [
                                      TableCell(child: basicDateField(key: startDateController)),
                                ]
                              ),
                              TableRow(
                                children: [
                                      TableCell(child: SizedBox(height: 24.0,)),
                                ]
                              ),
                              TableRow(
                                children: [
                                      TableCell(child: Text('End Date', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey))),
                                ]
                              ),
                              TableRow(
                                children: [
                                      TableCell(child: SizedBox(height: 24.0,)),
                                ]
                              ),
                              TableRow(
                                children: [
                                      TableCell(child: basicDateField(key: endDateController)),
                                ]
                              ),
                          ]
                    ),
                    

              ),
            ),
            Expanded(
              
              flex: 1,
              child:Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                                                  padding: EdgeInsets.all(18.0),
                                                  child: Text((widget.todo.isEdit) ? 'Save' : 'Create Now', style: TextStyle(fontSize: 20.0, color: Colors.white)),
                                                  color: Colors.black,
                                                  onPressed: () async {
                                                    if(todoController.text.isEmpty || startDateController.text.isEmpty || endDateController.text.isEmpty){
                                                      key.currentState.showSnackBar(new SnackBar(
                                                        content: Text("All Fields are required"),
                                                        action: SnackBarAction(
                                                        label: 'Dismiss',
                                                        onPressed: () {
                                                          //Navigator.pop(context, null);
                                                        },
                                                      ),
                                                      ));
                                                    }
                                                    else{
                                                        if(widget.todo.isEdit){
                                                          widget.todo.title = todoController.text;
                                                          DateFormat dateFormat = DateFormat(Formatters.yyyyMMdd);
                                                          DateTime startDate = dateFormat.parse(startDateController.text);
                                                          DateTime endDate = dateFormat.parse(endDateController.text);

                                                          widget.todo.startDate = startDate;
                                                          widget.todo.endDate = endDate;
                                                          Navigator.pop(context, widget.todo);
                                                        }
                                                        else{
                                                          Todo item = new Todo();
                                                          item.title = todoController.text;

                                                          DateFormat dateFormat = DateFormat(Formatters.yyyyMMdd);
                                                          DateTime startDate = dateFormat.parse(startDateController.text);
                                                          DateTime endDate = dateFormat.parse(endDateController.text);

                                                          item.startDate = startDate;
                                                          item.endDate = endDate;
                                                          Navigator.pop(context, item);
                                                        }
                                                        
                                                    }
                                                  },
                                      ),
                        )
              )
            )
          ],
      )
    );
  }
  }
Widget basicDateField(
      {@required TextEditingController key}) {
        final format = DateFormat("yyyy-MM-dd");
        return Column(children: <Widget>[
      DateTimeField(
        controller: key,
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
 }

