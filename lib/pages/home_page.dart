import 'package:flutter/material.dart';
import 'package:tese2k/data/http/http_client.dart';
import 'package:tese2k/data/repositories/moeda_repository.dart';
import 'package:tese2k/pages/stores/moeda_store.dart';
// Importe seu ProdutoStore aqui

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Inicializa a store
  late final ProdutoStore store;

  @override
  void initState() {
    super.initState();
    // Cria as dependências necessárias
    store = ProdutoStore(
      repository: MoedaRepository(
        client: HttpClient(),
      ),
    );
    // Carrega os dados ao iniciar
    store.getMoedas();
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cotações'),
      ),
      body: ValueListenableBuilder(
        valueListenable: store.isLoading,
        builder: (_, isLoading, __) {
          if (isLoading ) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ValueListenableBuilder(
            valueListenable: store.erro,
            builder: (_, erro, __) {
              if (erro.isNotEmpty) {
                return Center(
                  child: Text(erro),
                );
              }

              return ValueListenableBuilder(
                valueListenable: store.state,
                builder: (_, moedas, __) {
                  return ListView.builder(
                    itemCount: moedas.length,
                    itemBuilder: (_, index) {
                      final moeda = moedas[index];
                      return ListTile(
                        title: Text(moeda.name),
                        subtitle: Text('${moeda.code}/${moeda.codein}'),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: store.getMoedas,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}