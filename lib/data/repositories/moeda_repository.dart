import 'dart:convert';

import 'package:tese2k/data/http/exceptions.dart';
import 'package:tese2k/data/http/http_client.dart';
import 'package:tese2k/data/models/moedas_models.dart';

abstract class IMoedaRepository {
  Future<List<MoedaCot>> getCotacoes();
}

class MoedaRepository implements IMoedaRepository {
  final IHttpClient client;

  MoedaRepository({required this.client});

  @override
  Future<List<MoedaCot>> getCotacoes() async {
    final response = await client.get(
      url: 'https://economia.awesomeapi.com.br/json/last/USD-BRL',
    );

    if (response.statusCode == 200) {
      final List<MoedaCot> moedas = [];
      final body = jsonDecode(response.body);
      
      // Criando uma moeda a partir do objeto USDBRL
      final moeda = MoedaCot.fromMap(body['USDBRL']);
      moedas.add(moeda);

      return moedas;
    } else if (response.statusCode == 404) {
      throw NotFondException('A url informada não é válida');
    } else {
      throw Exception('Não foi possível carregar as cotações');
    }
  }
}