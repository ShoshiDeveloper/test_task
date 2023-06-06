import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'category.dart';

part 'api.g.dart';

@RestApi(baseUrl: "https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;


  @GET('/')
  Future<List<Category>> getCategories();
}