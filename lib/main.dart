import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<String> todos = [];

  void addToDo(value) {
    todos.add(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Lista de Tarefas'),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      '${index + 1} - ${todos[index]}',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Divider(
                    indent: 10,
                    endIndent: 10,
                    thickness: 2,
                    color: Colors.grey[200],
                  ),
                ],
              );
            }),
      ),
      floatingActionButton: Container(
        height: 80,
        width: 80,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(new MaterialPageRoute(
                    builder: (context) => new SecondPage()))
                .then((value) {
              if (value != null) {
                setState(() {
                  addToDo(value);
                });
              }
            });
          },
          child: Icon(Icons.add, size: 40),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _controller = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Formulário'),
      ),
      body: Column(
        children: [
          SafeArea(
            child: SizedBox(
              height: 300,
            ),
          ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(25),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preenchimento obrigatório!';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          SafeArea(
            child: SizedBox(
              height: 30,
            ),
          ),
          SafeArea(
            child: Container(
              height: 45,
              width: 90,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Navigator.of(context).pop(_controller.text);
                  }
                },
                child: Text(
                  'Salvar',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
