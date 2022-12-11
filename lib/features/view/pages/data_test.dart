import 'package:despy_app/features/core/models/model_transaction.dart';
import 'package:despy_app/features/view/controllers/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 0), () {
      final controller =
          Provider.of<TransactionController>(context, listen: false);
      controller.load();
    });
    super.initState();
  }

  void addTransaction() async {
    final provider = Provider.of<TransactionController>(context, listen: false);
    await provider.create(
      TransactionModel(
        id: "",
        value: 123.99,
        title: "title",
        description: "description",
        refCategory: "category",
        createAt: DateTime.now(),
        toRepeat: false,
        status: "active",
        type: "revenue",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionController>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: provider.isLoading
          ? const CircularProgressIndicator()
          : Column(
              children: <Widget>[
                SizedBox(
                  height: size.height,
                  width: size.width,
                  child: ListView.builder(
                    itemCount: provider.transactions.length,
                    itemBuilder: (context, index) {
                      final item = provider.transactions[index];
                      return ListTile(
                        title: Text(
                          item.title,
                          style: const TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(item.description ?? "Empty"),
                        trailing: IconButton(
                          onPressed: () => provider.remove(item.id),
                          icon: const Icon(
                            Icons.remove_circle_outlined,
                            color: Colors.red,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addTransaction(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
