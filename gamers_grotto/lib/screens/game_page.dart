import 'package:flutter/material.dart';

import '../widgets.dart';

class GamePage extends StatefulWidget{
  const GamePage({super.key});

  @override
  State<StatefulWidget> createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        title: const TitleText(),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return ChatLogDialog(chatLog: ['hello','please work']);
                }
              );
            },
            icon: Icon(Icons.chat, color: Theme.of(context).colorScheme.secondary),
          ),
          IconButton(
            onPressed: () { Navigator.pop(context);},
            icon: Icon(Icons.home_filled, color: Theme.of(context).colorScheme.secondary),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primary,
        child: Padding(padding: EdgeInsets.all(5),child:Row(
          children: <Widget>[
            Flexible(child:
              TextField(
                controller: chatController,
                decoration: const InputDecoration(hintText: 'Type Message Here',),
              ),
            ),
            Flexible(child:
              ElevatedButton(child: Text('Send Message!'), onPressed: null,),
            ),
          ],
        ),
      ),
      ),
    );
  }
}