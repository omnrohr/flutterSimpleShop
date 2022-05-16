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
    return AnimatedContainer(
      duration: Duration(microseconds: 300),
      // height: _withDetails
      //     ? min(widget.order.items.length * 20.0 + 115, 200)
      //     : 95, // error is gone
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
              subtitle: Text(
                  DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
              trailing: IconButton(
                  icon: Icon(
                      _withDetails ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _withDetails = !_withDetails;
                    });
                  }),
            ),
            // if (_withDetails)
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              // curve: Curves.easeIn,
              height: _withDetails
                  ? min(widget.order.items.length * 20.0 + 20, 100)
                  : 0,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                children: widget.order.items
                    .map((e) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.title,
                              style: TextStyle(fontSize: 20),
                            ),
                            Text('${e.quantity}x \$${e.price}',
                                style: TextStyle(fontSize: 16)),
                          ],
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
