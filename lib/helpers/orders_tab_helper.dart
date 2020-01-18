import 'dart:async';
import 'package:virtual_store/data/order.dart';
import 'package:virtual_store/repository/repository.dart';

Future<List<Order>> getUserOrders(String userId) async {
  final docs = await getUserOrdersFirebase(userId);

  List<Order> orders = [];
  docs.documents.forEach((doc) {
    final order = Order.fromMap(doc.data);
    order.id = doc.documentID;
    orders.add(order);
  });

  return orders;
}

Stream<Order> getOrderStatusStream(String orderId) {
  final orderStatus = getOrderStatusStreamFirebase(orderId);
  return orderStatus.map((doc) {
    final order = Order.fromMap(doc.data);
    order.id = doc.documentID;
    return order;
  });
}
