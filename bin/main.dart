library main;

import 'dart:async';
import 'package:jaguar/jaguar.dart';

@Api(path: '/api')
class Routes {
  @Get()
  Response<String> get(Context ctx) => Response.json('Hello buddy!');

  @Post()
  Future<Response<String>> post(Context ctx) async =>
      Response.json(await ctx.req.bodyAsJson());
}

main() async {
  final server = new Jaguar(port: 8000);
  server.addApiReflected(new Routes());
  server.log.onRecord.listen(print);
  await server.serve();
}
