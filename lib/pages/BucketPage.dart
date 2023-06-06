import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../API/dishes/dish.dart';
import '../blocs/bucket_bloc/bucket_bloc.dart';

class BucketPage extends StatefulWidget {
  const BucketPage({super.key});

  @override
  State<BucketPage> createState() => _BucketPageState();
}

class _BucketPageState extends State<BucketPage> {
var bloc = BucketBloc()..add(GetBucketDishesEvent());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          leading: const Icon(Icons.location_on_outlined, size: 24, color: Colors.black,),
          title: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Санкт-Петербург', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),),
              Text('12 августа, 2023',  style: TextStyle(fontSize: 14, color: Colors.black54),)
          ]),
          actions: [
            Image.asset('assets/images/user_image.png')
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      body: BlocProvider(
      create: (context) => bloc,
        child: SafeArea(
          child: BlocBuilder<BucketBloc, BucketState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is BucketLoadedState) {
                int _counter = 0;
                return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      runSpacing: 8,
                      children: state.dishes.map((e) {_counter++; return _dishBucketWidget(e, _counter-1);}).toList()
                    )
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('Оплатить ${bloc.priceSummary}'))
                ],);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )
        )
    ),
    );
  }

  
  Widget _dishBucketWidget(Dish dish, id) {
    return  Container(
        width: 343,
        height: 62,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
          dish.image_url != null ? Image.network(dish.image_url!) : Image.asset("assets/images/dish_image_isEmpty.png"),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(dish.name!, style: TextStyle(fontSize: 14),),
              RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: dish.price!.toString()),
                      const TextSpan(text: '₽ · '),
                      TextSpan(text: dish.weight!.toString(), style: const TextStyle(color: Colors.grey))
                    ]
                  )
                ),
            ],)
          ],
        ),
        Container(
          width: 100,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            InkWell(onTap: () {
              bloc.add(MinusBucketDishEvent(id));
            }, child: const Text('-', style: TextStyle(fontSize: 28),)),
            Text(dish.count.toString()),
            InkWell(onTap: () {
              bloc.add(PlusBucketDishEvent(id));
            }, child: const Text('+', style: TextStyle(fontSize: 24),))
          ],),
        )
        ],)
      );
  }
}