import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_card/cart_provider/provider.dart';
import 'package:shopping_card/constants/constant.dart';
import 'package:shopping_card/model/card_database.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  CardDataBase dataBase = CardDataBase();

  List<String> productList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTm2uIUQrCRTr5qkh7GL2DPwuDfXUc-ucZsRweBviPzHcx4j6UOif0vMOocKhYbVw8DxtA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGHyMdVCfHxiRsSM-YkHIwg1FhgAxpV_lXmw&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQriI1ituAY4nZsjpI0KmvlFc7raJkDsBtxiA&s',
    'https://images.unsplash.com/photo-1464965911861-746a04b4bca6?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8ZnJ1aXRzfGVufDB8fDB8fHww',
    'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fGZydWl0c3xlbnwwfHwwfHx8MA%3D%3D',
    'https://images.unsplash.com/photo-1587883012610-e3df17d41270?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDF8fHxlbnwwfHx8fHw%3D',
    'https://media.istockphoto.com/id/1208871135/photo/isolated-green-guava-with-pink-flesh.jpg?s=612x612&w=0&k=20&c=bzSFzraaPykVdTbQFHdLtd6ZneBnzDAIAYcXY4PyQdg=',
    'https://plus.unsplash.com/premium_photo-1661322640130-f6a1e2c36653?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://media.istockphoto.com/id/469799294/photo/cherry-group-of-berries-isolated-on-white.jpg?s=612x612&w=0&k=20&c=c3W8jsQqDnET4TvnKAH0rbFSkjUwrPPv75YaPCbF8ic=',
    'https://media.istockphoto.com/id/2155574186/photo/rows-of-both-unripe-and-ripe-guimaras-mangoes-renowned-for-its-exceptional-sweetness-at-a.jpg?s=612x612&w=0&k=20&c=bkvvM9-TXkROEivSlKkgBDYFzB_Ua2KxRmU6v7zyZXw='
  ];

  List<String> productName = ['Grapes','Orange','Pomegranate','Strawberry','Banana','Pineapple','Guava','Apple','Cherry','Mango'];

  List<String> productUnit = ['KG','Dozen','KG','KG','Dozen','Piece','KG','KG','KG','KG',];

List<int> productPrice = [50,30,50,60,20,40,80,10,20,50];


  @override
  Widget build(BuildContext context) {
    print('build');
    final provider = Provider.of<CartProvider>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product List',
          style: TextStyle(
            color: secondary,
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: primary,
        actions: [
          Consumer<CartProvider>(builder: (context,value,child){
            print('only build');
            return Badge.count(
              count: value.count,
              largeSize: 8,
              child: Icon(Icons.shopping_cart, color: secondary),
            );
          }),
          SizedBox(width: 20),
        ],
      ),
      body: ListView.builder(
          itemCount: productList.length,
          itemBuilder: (context,index){
            return Column(
              children: [
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      spacing: 10,
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundImage: NetworkImage(productList[index])
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(productName[index],style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                              ),),
                              Text('${productUnit[index]}  Rs.${productPrice[index]}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500
                                  )
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: InkWell(
                                  onTap: (){
                                    provider.increment();
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: primary,
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Center(child: Text('Add to Card',style: TextStyle(
                                        color: secondary,
                                    fontWeight: FontWeight.w500
                                    ),)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ),
                SizedBox(height: 5,)
              ],
            );
          }),
    );
  }
}
