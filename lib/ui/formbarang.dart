import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/item.dart';
import '../helper/sqlhelper.dart';

class EntryForm extends StatefulWidget {
  const EntryForm({
    Key? key,
    Item? item,
  }) : super(key: key);

  @override
  State<EntryForm> createState() => EntryFormState();
}

class EntryFormState extends State<EntryForm> {
  Item item = Item(name: '', price: 0, kode: '', stok: 0);

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController kodeController = TextEditingController();
  TextEditingController stokController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (item == '') {
      nameController.text = item.name;
      priceController.text = item.price.toString();
      kodeController.text = item.kode;
      stokController.text = item.stok.toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: item != null ? const Text('Tambah') : const Text('Ubah'),
        leading: const Icon(Icons.keyboard_arrow_left),
      ),
      body: ListView(
        children: <Widget>[
          // nama barang
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: TextField(
                controller: kodeController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  icon: Icon(Icons.shopping_basket),
                  labelText: 'Kode Barang',
                ),
                onChanged: (value) {}),
          ),

          // harga barang
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  icon: Icon(Icons.label_important_outline_sharp),
                  labelText: 'Nama Barang',
                ),
                onChanged: (value) {
                  //item.name = value;
                }),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  icon: Icon(Icons.attach_money),
                  labelText: 'Harga Barang',
                ),
                onChanged: (value) {
                  // item.price = int.parse(value);
                }),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: TextField(
                controller: stokController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  icon: Icon(Icons.inventory_rounded),
                  labelText: 'Stok Barang',
                ),
                onChanged: (value) {}),
          ),

          // tombol button
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Row(
              children: <Widget>[
                // tombol simpan
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text(
                      'Save',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      if (item.name == '') {
                        // tambah data
                        item = Item(
                            name: nameController.text,
                            price: int.parse(priceController.text),
                            kode: kodeController.text,
                            stok: int.parse(stokController.text));
                        final Future<Database> dbFuture = SQLHelper.db();
                        Future<int> id = SQLHelper.createItem(item);
                      } else {
                        // ubah data
                        item.name = nameController.text;
                        item.price = int.parse(priceController.text);
                        item.kode = kodeController.text;
                        item.stok = int.parse(stokController.text);
                      }

                      // kembali ke layar sebelumnya dengan membawa objek item
                      //print(item);
                      Navigator.pop(context, item);
                    },
                  ),
                ),

                Container(
                  width: 5.0,
                ),

                // tombol batal
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.cancel),
                    label: const Text(
                      'Cancel',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
