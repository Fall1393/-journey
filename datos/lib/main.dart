import 'package:datos/database.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'SQLITE Demo'),

    );

  }
}
class MyHomePage extends StatefulWidget{
  MyHomePage({Key key, this.title}): super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage>{
  TaskDatabase db = TaskDatabase();
 
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: db.initDB(),
        builder: (BuildContext context, snapshot){
          if (snapshot.connectionState == ConnectionState.done){
            return _showList(context);
          
          }else{
            return Center(
              child: CircularProgressIndicator(), 
            );
          }
        },  
      ),

        floatingActionButton: FloatingActionButton(
          onPressed: _addTask,
          tooltip: 'Increment',
          child: Icon(Icons.add), 
          ),
    );
  }

  _showList(BuildContext context){
    return FutureBuilder(
      future: db.getAllTasks(),
      initialData: List<Task>(),
      builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot){
        
        if (snapshot.hasData){

        
        return ListView(
          children: <Widget>[
            for (Task task in snapshot.data) ListTile(title: Text(task.name))
          ],
        );
        } else{
          return Center(
            child: Text("add tasks!"),
          );
        }
      },

    );
  } 


  _addTask(){
    showDialog(
      context: context,
      builder: (context){
        return SimpleDialog(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(icon: Icon(Icons.add_circle_outline)),
              onSubmitted: (text){
                setState(() {
                  var task = Task(text);
                  db.insert(task);
                  Navigator.pop(context);
                  
                });
              }
            )
          ],
        );
      },
    );
  }
}