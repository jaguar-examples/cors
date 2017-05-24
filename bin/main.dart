library main;

import 'package:jaguar/jaguar.dart';
import 'package:jaguar_mux/jaguar_mux.dart';
import 'package:jaguar_cors/jaguar_cors.dart';

main() async {
  final builder = new MuxBuilder();

  builder.get('/none', () {
    return 'none';
  }).wrap(new WrapCors(new CorsOptions()));

  final options1 = new CorsOptions(
      allowedOrigins: ['http://example.com', 'http://example1.com'],
      allowAllMethods: true,
      allowAllHeaders: true);
  builder.get('/origins', () => 'origins').wrap(new WrapCors(options1));

  final options2 = new CorsOptions(
      allowedOrigins: ['http://example.com'],
      allowAllMethods: true,
      allowAllHeaders: true);
  builder.route('/preflight', () => 'preflight',
      methods: ['OPTIONS']).wrap(new WrapCors(options2));

  Jaguar conf = new Jaguar();
  conf.addApi(builder.build());
  await conf.serve();
}