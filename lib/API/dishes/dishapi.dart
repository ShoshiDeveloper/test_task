import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'dish.dart';

part 'dishapi.g.dart';

@RestApi(baseUrl: "https://run.mocky.io/v3/c7a508f2-a904-498a-8539-09d96785446e")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/')
  Future<List<Dish>> getDishes();
}