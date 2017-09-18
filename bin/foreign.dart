library main;

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
  @Route(methods: const ['OPTIONS'])
  @WrapOne(#cors)
  void options(Context ctx) {}

  @Get()
  @WrapOne(#cors)
  Response<String> get(Context ctx) {
    return Response.json('Hello foreigner!');
  }
}

main() async {
  final server = new Jaguar(port: 9000);
  server.addApiReflected(new Routes());
  server.log.onRecord.listen(print);
  await server.serve();
}
