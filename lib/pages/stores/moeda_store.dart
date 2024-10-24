import 'package:flutter/material.dart';
import 'package:tese2k/data/http/exceptions.dart';
import 'package:tese2k/data/models/moedas_models.dart';
import 'package:tese2k/data/repositories/moeda_repository.dart';

class ProdutoStore {
  final IMoedaRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<MoedaCot>> state = ValueNotifier<List<MoedaCot>>([]);
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ProdutoStore({required this.repository}); // Corrigido o nome do construtor

  Future<void> getMoedas() async {
    isLoading.value = true;

    try {
      final result = await repository.getCotacoes();
      state.value = result;
      erro.value = ''; // Limpa o erro em caso de sucesso
    } on NotFondException catch (e) {
      erro.value = e.message; // Corrigido o operador de atribuição
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }

  void dispose() {}
}