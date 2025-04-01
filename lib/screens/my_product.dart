import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_card/model/card_database.dart';
import 'package:shopping_card/model/card_model.dart';

import '../cart_provider/provider.dart';
import '../constants/constant.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  CardDataBase dataBase = CardDataBase();
  @override
  Widget build(BuildContext context) {
    print(' All build');
    final provider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Product',
          style: TextStyle(
            color: secondary,
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: primary,
        actions: [
          Consumer<CartProvider>(
            builder: (context, value, child) {
              return Badge.count(
                count: value.getCounter(),
                largeSize: 8,
                child: Icon(Icons.shopping_cart, color: secondary),
              );
            },
          ),
          SizedBox(width: 20),
        ],
      ),
      body: FutureBuilder(
        future: provider.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child:
                      snapshot.data!.isEmpty
                          ? Center(
                            child: Text(
                              'No Products Selected',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                          : ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Consumer<CartProvider>(
                                    builder: (context, value, child) {
                                      return Card(
                                        elevation: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            spacing: 5,
                                            children: [
                                              CircleAvatar(
                                                radius: 45,
                                                backgroundImage: NetworkImage(
                                                  snapshot.data![index].image
                                                      .toString(),
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      snapshot
                                                          .data![index]
                                                          .productName
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${snapshot.data![index].unitTag}  Rs.${snapshot.data![index].productPrice}',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                spacing: 10,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {});
                                                      dataBase.deleteData(
                                                        snapshot
                                                            .data![index]
                                                            .id,
                                                      );
                                                      provider.decrement();
                                                      int price =
                                                          snapshot
                                                              .data![index]
                                                              .productPrice! *
                                                          snapshot
                                                              .data![index]
                                                              .quantity!;
                                                      provider.removePrice(
                                                        double.parse(
                                                          price.toString(),
                                                        ),
                                                      );
                                                      value.selection.remove(
                                                        snapshot
                                                            .data![index]
                                                            .productName,
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 30,
                                                      width: 114,
                                                      decoration: BoxDecoration(
                                                        color: primary,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              5,
                                                            ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Remove',
                                                          style: TextStyle(
                                                            color: secondary,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 30,
                                                    width: 114,
                                                    decoration: BoxDecoration(
                                                      color: primary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            5,
                                                          ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            int quantity =
                                                                snapshot
                                                                    .data![index]
                                                                    .quantity!;
                                                            if (quantity > 1) {
                                                              setState(() {});
                                                              quantity--;

                                                              dataBase
                                                                  .updateQuantity(
                                                                    Cart(
                                                                      id:
                                                                          snapshot
                                                                              .data![index]
                                                                              .id,
                                                                      productId:
                                                                          snapshot
                                                                              .data![index]
                                                                              .productId,
                                                                      productName:
                                                                          snapshot
                                                                              .data![index]
                                                                              .productName,
                                                                      initialPrice:
                                                                          snapshot
                                                                              .data![index]
                                                                              .initialPrice,
                                                                      productPrice:
                                                                          snapshot
                                                                              .data![index]
                                                                              .productPrice,
                                                                      quantity:
                                                                          quantity,
                                                                      unitTag:
                                                                          snapshot
                                                                              .data![index]
                                                                              .unitTag,
                                                                      image:
                                                                          snapshot
                                                                              .data![index]
                                                                              .image,
                                                                    ),
                                                                  )
                                                                  .then((
                                                                    onValue,
                                                                  ) {
                                                                    provider.removePrice(
                                                                      double.parse(
                                                                        snapshot
                                                                            .data![index]
                                                                            .productPrice
                                                                            .toString(),
                                                                      ),
                                                                    );
                                                                  });
                                                            }
                                                          },
                                                          icon: Icon(
                                                            Icons.remove,
                                                            weight: 20,
                                                          ),
                                                          color: secondary,
                                                        ),
                                                        Text(
                                                          snapshot
                                                              .data![index]
                                                              .quantity
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: secondary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            int quantity =
                                                                snapshot
                                                                    .data![index]
                                                                    .quantity!;
                                                            if (quantity < 99) {
                                                              setState(() {});

                                                              quantity++;

                                                              dataBase
                                                                  .updateQuantity(
                                                                    Cart(
                                                                      id:
                                                                          snapshot
                                                                              .data![index]
                                                                              .id,
                                                                      productId:
                                                                          snapshot
                                                                              .data![index]
                                                                              .productId,
                                                                      productName:
                                                                          snapshot
                                                                              .data![index]
                                                                              .productName,
                                                                      initialPrice:
                                                                          snapshot
                                                                              .data![index]
                                                                              .initialPrice,
                                                                      productPrice:
                                                                          snapshot
                                                                              .data![index]
                                                                              .productPrice,
                                                                      quantity:
                                                                          quantity,
                                                                      unitTag:
                                                                          snapshot
                                                                              .data![index]
                                                                              .unitTag,
                                                                      image:
                                                                          snapshot
                                                                              .data![index]
                                                                              .image,
                                                                    ),
                                                                  )
                                                                  .then((
                                                                    onValue,
                                                                  ) {
                                                                    provider.addPrice(
                                                                      double.parse(
                                                                        snapshot
                                                                            .data![index]
                                                                            .productPrice
                                                                            .toString(),
                                                                      ),
                                                                    );
                                                                  });
                                                            }
                                                          },
                                                          icon: Icon(Icons.add),
                                                          color: secondary,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 5),
                                ],
                              );
                            },
                          ),
                ),
                Visibility(
                  visible:
                      provider.getPrice().toString() == '0.0' ? false : true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Price',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Consumer<CartProvider>(
                          builder: (context, value, child) {
                            return Text(
                              'Rs. ${value.getPrice()}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
