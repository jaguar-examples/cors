library main;

import 'dart:async';
import 'package:jaguar/jaguar.dart';

@Api(path: '/api')
class Routes {
  @Get()
  String get(Context ctx) => 'Hello buddy!';
  
  @Post()
  Future<String> post(Context ctx) => ctx.req.bodyAsText();
}

main() async {
  final server = new Jaguar();
  server.addApiReflected(new Routes());
  await server.serve();
}