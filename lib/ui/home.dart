import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/item.dart';
import '../helper/sqlhelper.dart';
import 'formbarang.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int count = 0;
  List<Item> itemList = [];

  @override
  void initState() {
    updateListView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Daftar Item',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          elevation: 20.0,
        ),
        body: Column(
          children: [
            const SizedBox(height: 5),
            Expanded(
              child: createListView(),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EntryForm()),
                  ).then((value) {
                    updateListView();
                  });
                },
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ));
  }

  ListView createListView() {
    TextStyle? textStyle = Theme.of(context).textTheme.headlineSmall;
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) => Card(
              color: const Color.fromRGBO(63, 60, 60, 0.447),
              elevation: 20.0,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    itemList[index].name.substring(0,
                        1), // Mengambil karakter pertama dari itemList[index].name
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                title: Text(
                  itemList[index].name,
                  style: textStyle,
                ),
                subtitle: Text(
                  'Kode: ${itemList[index].kode}\n'
                  'Price: ${itemList[index].price.toString()}\n'
                  'Stok: ${itemList[index].stok.toString()}',
                ),
                trailing: GestureDetector(
                  child: const Icon(Icons.delete),
                  onTap: () async {
                    await SQLHelper.deleteItem(itemList[index].id);
                    updateListView();
                  },
                ),
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EntryForm(item: itemList[index]),
                    ),
                  ).then((value) {
                    updateListView();
                  });
                },
              ),
            ));
  }

  void updateListView() {
    final Future<Database> dbFuture = SQLHelper.db();
    dbFuture.then((database) {
      Future<List<Item>> itemListFuture = SQLHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          count = itemList.length;
        });
      });
    });
  }
}
