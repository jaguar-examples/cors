library main;

import 'dart:async';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar_reflect/jaguar_reflect.dart';
import 'package:jaguar_cors/jaguar_cors.dart';

const corsOptions = CorsOptions(
    // Allow CORS requests from mine.com
    allowedOrigins: const ['http://mine.com'],
    // Allow all headers
    allowAllHeaders: true,
    // Allow all methods
    allowAllMethods: true);

@GenController(path: '/api')
class Routes extends Controller {
  @HttpMethod(methods: const ['GET', 'OPTIONS'])
  Response<String> get(Context ctx) {
    if (ctx.req.method != 'GET') return null;
    return Response.json('Hello foreigner!');
  }

  @HttpMethod(methods: const ['POST', 'OPTIONS'])
  Future<Response<String>> post(Context ctx) async {
    if (ctx.req.method != 'POST') return null;
    return Response.json(await ctx.bodyAsJson());
  }

  @override
  void before(Context ctx) {
    Cors(corsOptions).call(ctx);
  }
}

main() async {
  final server = Jaguar(port: 9000);
  server.add(reflect(Routes()));
  server.log.onRecord.listen(print);
  await server.serve();
}
