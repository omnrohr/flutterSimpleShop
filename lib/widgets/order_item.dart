import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../models/order.dart' as order_model;

class OrderItem extends StatefulWidget {
  final order_model.OrderItem order;
  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _withDetails = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
            subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
                icon:
                    Icon(_withDetails ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _withDetails = !_withDetails;
                  });
                }),
          ),
          if (_withDetails)
            Container(
              height: min(widget.order.items.length * 20.0 + 35, 100),
              child: ListView(
                children: widget.order.items
                    .map((e) => Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                e.title,
                                style: TextStyle(fontSize: 20),
                              ),
                              Text('${e.quantity}x \$${e.price}',
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
