library main;

import 'dart:async';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar_cors/jaguar_cors.dart';

abstract class CorsHelper {
  static const options1 = const CorsOptions(
      allowedOrigins: const ['http://mine.com'],
      // allowedHeaders: const ['X-Requested-With'],
      allowAllHeaders: true,
      allowAllMethods: true);

  Cors cors(Context ctx) => new Cors(options1);
}

@Api(path: '/api')
class Routes extends Object with CorsHelper {
  @Route(methods: const ['GET', 'OPTIONS'])
  @WrapOne(#cors)
  Response<String> get(Context ctx) {
    if(ctx.req.method != 'GET') return null;
    return Response.json('Hello foreigner!');
  }

  @Route(methods: const ['POST', 'OPTIONS'])
  @WrapOne(#cors)
  Future<Response<String>> post(Context ctx) async {
    if(ctx.req.method != 'POST') return null;
    return Response.json(await ctx.req.bodyAsJson());
  }
}

main() async {
  final server = new Jaguar(port: 9000);
  server.addApiReflected(new Routes());
  server.log.onRecord.listen(print);
  await server.serve();
}
