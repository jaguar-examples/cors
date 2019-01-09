library main;

import 'dart:async';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar_reflect/jaguar_reflect.dart';

@GenController(path: '/api')
class Routes extends Controller {
  @Get()
  Response<String> get(Context ctx) => Response.json('Hello buddy!');

  @Post()
  Future<Response<String>> post(Context ctx) async =>
      Response.json(await ctx.bodyAsJson());
}

main() async {
  final server = Jaguar(port: 8000);
  server.add(reflect(Routes()));
  server.log.onRecord.listen(print);
  await server.serve();
}
