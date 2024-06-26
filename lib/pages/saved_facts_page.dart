import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SavedFactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final box = Hive.box('catFacts');

    return Scaffold(
      appBar: AppBar(
        title: Text('Збережені факти'),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box box, _) {
          if (box.values.isEmpty) {
            return Center(
              child: Text('Немає збережених фактів.'),
            );
          }

          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              final fact = box.getAt(index);

              return Slidable(
                startActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        box.deleteAt(index);
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Видалити',
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(fact),
                ),
              );
            },
          );
        },
      ),
    );
  }
}