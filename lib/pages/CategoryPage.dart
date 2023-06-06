import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../API/dishes/dish.dart';
import '../StaticData.dart';
import '../blocs/dishes_bloc/dish_bloc.dart';

class CategoryPage extends StatefulWidget {
  final Function()? goBackTap;
  final String category;
  const CategoryPage({super.key,required this.category, this.goBackTap});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String _tagSelected = 'Все меню';
  @override
  Widget build(BuildContext context) {
    var bloc = DishBloc()..add(GetDishesEvent());
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(onPressed: widget.goBackTap, icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 24, color: Colors.black,)),
          title: 
              Text(widget.category, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black,)),
          actions: [
            Image.asset('assets/images/user_image.png')
          ],
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      body: BlocProvider(
        create: (context) => bloc,
        child: SafeArea(
          child: Center(
            child: Column(children: [
              Row(children: [
                _selectTagButton('Все меню'),
                const SizedBox(width: 8),
                _selectTagButton('Салаты'),
                const SizedBox(width: 8),
                _selectTagButton('С рисом'),
                const SizedBox(width: 8),
                _selectTagButton('С рыбой')
              ],),
              BlocBuilder<DishBloc, DishState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is DishLoadedState) {
                    return SingleChildScrollView(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        // crossAxisAlignment: WrapCrossAlignment.center,
                        runSpacing: 8,
                        spacing: 8,
                        children: state.dishes.where((Dish element) => element.tegs!.contains(_tagSelected)).map((e) => _itemWidget(e)).toList()
                      ),
                    );
                  } else {
                    return const  CircularProgressIndicator();
                  }
                },
              )
            ],)
          ),
        )
      )
    );
  }

  ElevatedButton _selectTagButton(String tag) {
    return ElevatedButton(onPressed: () {
      setState(() {
        _tagSelected = tag;
      });
    },
    style: ButtonStyle(
      elevation: MaterialStatePropertyAll(0),
      backgroundColor: _tagSelected == tag ? MaterialStatePropertyAll(Colors.blue[600]) : MaterialStatePropertyAll(Colors.grey[300]),
      foregroundColor: _tagSelected == tag ? MaterialStatePropertyAll(Colors.white) : MaterialStatePropertyAll(Colors.black)
    ),
    child: Text(tag));
  }


  Widget _itemWidget(Dish dish) {
    return InkWell(
      child: Column(children: [
        Container(
          width: 109,
          height: 109,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromRGBO(248, 247, 245, 1),
          ),
          //у вас на 4м блюде нет описания, а есть картинка
          child: dish.image_url != null ? Image.network(dish.image_url!) : Image.asset("assets/images/dish_image_isEmpty.png"),
        ),
        SizedBox(
          width: 110,
          child: Text(dish.name!),
        )
      ],),
      onTap: () {
        _openDish(dish);
      },
    );
  }

  void _openDish(Dish dish) {
    showDialog(context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16),
          content: Container(
            color: Colors.white,
            width: 343,
            height: 446,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                alignment: Alignment.center,
                width: 311,
                height: 232,
                color: const Color.fromRGBO(248, 247, 245, 1),
                child: Stack(alignment: Alignment.topCenter, children: [
                  dish.image_url != null ? Image.network(dish.image_url!) : Image.asset("assets/images/dish_image_isEmpty.png"),
                  Container(width: 311, padding: EdgeInsets.all(8),
                    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    InkWell(
                      child: Container(
                        width: 40,
                        height: 40,
                        color: Colors.white,
                        child: Icon(Icons.favorite_border_rounded)
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(width: 8,),
                    InkWell(
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // border: Border.all() 
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Icon(Icons.close)
                      ),
                      onTap: () {},
                    )
                  ],)
                  )
                ],),
              ),
              
              const SizedBox(height: 8,),
              Text(dish.name!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
              const SizedBox(height: 8,),
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
              const SizedBox(height: 8,),
              Text(dish.description!, style: TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis), maxLines: 5,),
              const SizedBox(height: 16,),
              ElevatedButton(onPressed: () {
                StaticData.dishes.add(dish);
                Navigator.pop(context);
              }, 
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(311, 48)),
                backgroundColor: MaterialStateProperty.all(Colors.blue[700])
              ),
                child: const Text('Добавить в корзину', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
              )
            ],),
          ),
        );
      },
    );
  }

}