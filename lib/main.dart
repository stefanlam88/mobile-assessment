import 'package:flutter/material.dart';
import 'package:etiqa_assessment/user/screens/screens.dart';
import 'package:etiqa_assessment/extensions.dart';
import 'package:intl/intl.dart';
import 'package:etiqa_assessment/user/models/Todo.dart';
import 'package:etiqa_assessment/utils/formatters.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
        primaryTextTheme: TextTheme(
          title: TextStyle(
            color: Colors.black
          )
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          labelStyle: TextStyle(
            color: HexColor.fromHex("#CCC"),
            fontSize: 24.0
          ),
        ),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  List<Todo> data = new List<Todo>();
  DateFormat expectedFormat = DateFormat(Formatters.ddMY);
  @override
  void initState() {
    super.initState();
    //default item
    Todo newTodo = new Todo();
    newTodo.title = 'Automated Testing Script';
    newTodo.isTick = false;
    newTodo.status = 'Incomplete';
    //hardcoded for demo purpose
    DateFormat dateFormat = DateFormat(Formatters.yyyyMMdd);
    DateTime startDate = dateFormat.parse("2019-10-21 00:00:00");
    DateTime endDate = dateFormat.parse("2020-02-23 00:00:00");

    newTodo.startDate = startDate;
    newTodo.endDate = endDate;
    newTodo.isEdit = true;
    data.add(newTodo);
  }

  void onTapped(BuildContext context, Todo data, int index)   {
    // navigate to the next screen.
    
      Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserDetails(todo: data)),
      );
    
}

void getDetails(Todo todoCallback, int index) {

   todoCallback.isEdit = true;
   data.add(todoCallback);
}

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          'To-Do List',
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: ListView.builder(
        itemCount: data.length,
        padding: EdgeInsets.all(30.0),
        itemBuilder: (context, index) {
          return InkWell(
                onTap: () async => onTapped(context, data[index], index),
                child: Card(
                elevation:5,
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                ),
                child: Column(
                      children: <Widget>[
                        Column(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(12.0),
                              ),
                              Column(children: <Widget>[
                                Text(data[index].title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              ],)
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          Table(
                            children: [
                              TableRow(
                                children: [
                                  TableCell(child: Center(child: Text('Start Date', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)))),
                                  TableCell(child: Center(child: Text('End Date', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)))),
                                  TableCell(child: Center(child: Text('Time Left', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)))),
                                ]
                              ),
                            ]
                          ),
                          SizedBox(height: 5.0,),
                          Table(
                            children: [
                              TableRow(
                                children: [
                                  TableCell(child: Center(child: Text(Formatters.dateToFormat(data[index].startDate, expectedFormat), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black)))),
                                  TableCell(child: Center(child: Text(Formatters.dateToFormat(data[index].endDate, expectedFormat), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black)))),
                                  TableCell(child: Center(child: Text(Formatters.dateDifference(DateTime.now(), data[index].endDate), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black)))),
                                ]
                              ),
                            ]
                          ),
                          SizedBox(height: 25.0,),
                          Container(
                            color: (data[index].isTick ? HexColor.fromHex("#b2f0bb") : HexColor.fromHex("#e8e2d0")),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 4, // 20%
                                  child: Container(
                                    margin: EdgeInsets.only(left: 25.0),
                                    child: Row(children: <Widget>[
                                      Text('Status', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 11)),
                                      Padding(
                                        padding: EdgeInsets.all(4.0),
                                      ),
                                      Text(data[index].status, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                                    ],),
                                  ),
                                ),
                                Expanded(
                                  flex: 2, // 60%
                                  child: Container(color: Colors.green),
                                ),
                                Expanded(
                                  flex: 4, // 20%
                                  child: Container(
                                    child: Row(children: <Widget>[
                                      Text("Tick if completed", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 11)),
                                      Checkbox(
                                          value: data[index].isTick,
                                          onChanged: (bool value) {
                                              setState(() {
                                                if(data[index].isTick){
                                                  data[index].isTick = false;
                                                  data[index].status = 'Incomplete';
                                                }
                                                else{
                                                  data[index].isTick = true;
                                                  data[index].status = 'Completed';
                                                }
                                                  
                                              });
                                          },
                                      ),
                                    ],),
                                  ),
                                )
                              ]
    
                            ),
                          )
                          
                        ],
                        )
                      ],
                    ),
                
                
                )
          );
        }
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(bottom: 100.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            onPressed: () {
              Todo todo = new Todo();
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserDetails(todo: todo)),
              ).then((val){
                getDetails(val, 0);
              });
              
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.redAccent
          ),
        ),
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

