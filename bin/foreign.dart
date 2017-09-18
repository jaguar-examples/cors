library main;

import 'package:jaguar/jaguar.dart';
import 'package:jaguar_cors/jaguar_cors.dart';

abstract class CorsHelper {
  final options1 = new CorsOptions(
      allowedOrigins: ['http://example.com', 'http://example1.com'],
      allowAllMethods: true,
      allowAllHeaders: true);

  Cors cors(Context ctx) => new Cors(options1);
}

@Api(path: '/api')
class Routes extends Object with CorsHelper {
  @Get()
  @WrapOne(#cors)
  String get(Context ctx) => 'Hello foreigner!';
}

main() async {
  final server = new Jaguar();
  server.addApiReflected(new Routes());
  await server.serve();
}