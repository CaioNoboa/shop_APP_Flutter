import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order_widget.dart';
import 'package:shop/models/order_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);
  // bool _isLoading = true;

  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<OrderList>(context, listen: false).loadOrders().then((value) {
  //     setState(() => _isLoading = false);
  //   });
  // }

  Future<void> _refreshOrders(BuildContext context) {
    return Provider.of<OrderList>(context, listen: false).loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    // final OrderList orders = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Meus pedidos'),
      ),
      body: FutureBuilder(
        future: Provider.of<OrderList>(context, listen: false).loadOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('Ocorreu um erro!'));
          } else {
            return Consumer<OrderList>(
              builder: (context, orders, child) {
                return RefreshIndicator(
                  onRefresh: () => _refreshOrders(context),
                  child: ListView.builder(
                    itemCount: orders.itemsCount,
                    itemBuilder: (context, index) {
                      return OrderWidget(order: orders.items[index]);
                    },
                  ),
                );
              },
            );
          }
        },
      ),

      // Mesmo em um stateless podemos trabalhar estado com FutureBuilder


      // body: _isLoading
      //     ? Center(child: CircularProgressIndicator())
      //     : RefreshIndicator(
      //         onRefresh: () => _refreshOrders(context),
      //         child: ListView.builder(
      //           itemCount: orders.itemsCount,
      //           itemBuilder: (context, index) {
      //             return OrderWidget(order: orders.items[index]);
      //           },
      //         ),
      //       ),

      drawer: AppDrawer(),
    );
  }
}
