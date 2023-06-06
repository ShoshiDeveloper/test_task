import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/categories_bloc/categories_bloc.dart';

class MainPage extends StatefulWidget {
  final Function(String category) onTapCategory;
  const MainPage({super.key, required this.onTapCategory});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    var bloc = CategoriesBloc()..add(GetCategoriesEvent());
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
      child: Center(
        child: SafeArea(
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is CategoriesLoaded) {
                return SingleChildScrollView(
                  child: Wrap(
                    runSpacing: 8,
                    children: state.categories.map((e) => _categoryWidget(e.name!, e.image_url!, widget.onTapCategory)).toList()
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )
        )
      )
    ),
    );
  }

  
  Widget _categoryWidget(String name, String url, Function(String category) onTap) {
    return InkWell(
      child: Container(
        width: 343,
        height: 148,
        padding: EdgeInsets.only(left: 16, top: 12),
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(url))
        ),
        child: Text(name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
      ),
      onTap: () {
        onTap(name);
      },
    );
  }
}