import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/api_service/firebase_crud_service/stock_service/models/stock_model.dart';
import '../../core/api_service/firebase_crud_service/stock_service/stock_service.dart';
import '../../design/widgets/mt_loader.dart';
import '../../main.dart';
import '../dashboard/bloc/dashboard_bloc.dart';

Future<String> loadStockAsset() async {
  return await rootBundle.loadString('assets/stocks.json');
}

Future<List<StockModel>> loadStocks() async {
  String jsonString = await loadStockAsset();
  final jsonResponse = json.decode(jsonString);
  StockBundle s = StockBundle.fromJson(jsonResponse);
  return s.stocks;
}

class StockBundle {
  final List<StockModel> stocks;

  StockBundle(this.stocks);

  factory StockBundle.fromJson(List<dynamic> parsedJson) {
    List<StockModel> stocks = <StockModel>[];
    stocks = parsedJson.map((i) {
      var stockModel = StockModel(
        id: i['Sr No'],
        name: i['Company Name'],
        symbol: i['Symbol'],
      );

      return stockModel;
    }).toList();
    return StockBundle(stocks);
  }
}

class StockSearchDelegate extends SearchDelegate<String> {
  StockSearchDelegate();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: loadStocks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              if (query.length >= 3 &&
                  snapshot.data![index].name
                      .toLowerCase()
                      .startsWith(query.toLowerCase())) {
                return GestureDetector(
                  child: ListTile(
                    title: Text(snapshot.data![index].name),
                    leading: const Icon(Icons.location_city),
                  ),
                  onTap: () {
                    // TODO: Change auth api call
                    final id = sharedPref.getString('id');
                    final StockModel stock = snapshot.data![index];
                    StockApiService.createDoc(stock, id!);
                    BlocProvider.of<DashboardBloc>(context)
                        .add(DashboardIndexChangedEvent(0));
                    close(context, '');
                  },
                );
              } else {
                return const Column();
              }
            },
            itemCount: snapshot.data!.length,
          );
        } else if (snapshot.hasError) {
          return const Text("Snapshot Error");
        } else {
          return const Center(
            child: MtLoader(),
          );
        }
      },
    );
  }
}
