// Copyright (c) 2017, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:http/browser_client.dart';
import 'package:jaguar_client/jaguar_client.dart';

class StatusElement {
  final String title;

  final JsonResponse response;

  StatusElement(this.title, this.response);

  void mount(Element parent) {
    final String innerHtml = '''
    <div class="title">$title</div>
    <div class="field">
      <div>Response: </div>
      <div>${response.body}</div>
    </div>
    <div class="field">
      <div>Status: </div>
      <div>${response.statusCode}</div>
    </div>
    ''';
    final el = new DivElement()
      ..classes.add('status')
      ..innerHtml = innerHtml;
    parent.append(el);
  }
}

main() async {
  final Element body = querySelector('body');
  final jClient = new JsonClient(new BrowserClient());

  new StatusElement('Local Get', await jClient.get('/api/')).mount(body);

  new StatusElement(
          'Local Post', await jClient.post('/api/', body: 'Posting buddy!'))
      .mount(body);

  new StatusElement('Cors Get', await jClient.get('http://foreign.com/api/'))
      .mount(body);

  //TODO
}
