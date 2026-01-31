import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AppListing {
  final String id;
  final String title;
  final String description;
  final String author;
  int votes;
  double? offerValue; // Se != null, recebeu oferta
  final String category;

  AppListing({
    String? id,
    required this.title,
    required this.description,
    required this.author,
    this.votes = 0,
    this.offerValue,
    required this.category,
  }) : id = id ?? const Uuid().v4();
}

class MarketplaceProvider extends ChangeNotifier {
  final List<AppListing> _listings = [
    AppListing(
      title: "Uber de Pets",
      description: "Passeadores de cães sob demanda com GPS real-time.",
      author: "Ana Souza",
      votes: 15420,
      category: "Serviços",
      offerValue: 5000.00,
    ),
    AppListing(
      title: "Treta Política",
      description:
          "Rede social apenas para debates políticos moderados por IA.",
      author: "Carlos M.",
      votes: 12300,
      category: "Social",
      offerValue: 2500.00,
    ),
    AppListing(
      title: "Calculadora RH 2026",
      description: "Cálculos trabalhistas atualizados com a nova CLT.",
      author: "DevRH",
      votes: 8900,
      category: "Produtividade",
    ),
    AppListing(
      title: "Fitness Gamificado",
      description: "RPG onde você upa de nível malhando na vida real.",
      author: "FitNerd",
      votes: 4500,
      category: "Saúde",
    ),
    AppListing(
      title: "Receitas com o que tem",
      description: "IA sugere receitas com base na foto da sua geladeira.",
      author: "ChefTech",
      votes: 3200,
      category: "Estilo de Vida",
    ),
  ];

  List<AppListing> get listings {
    // Retorna ordenado por votos (maior para menor)
    var list = [..._listings];
    list.sort((a, b) => b.votes.compareTo(a.votes));
    return list;
  }

  List<AppListing> get top3 => listings.take(3).toList();

  void vote(String id) {
    var app = _listings.firstWhere((a) => a.id == id);
    app.votes++;
    _checkForOffer(app);
    notifyListeners();
  }

  void _checkForOffer(AppListing app) {
    // Simula a lógica de oferta automática do "Shark Tank"
    if (app.offerValue == null && app.votes > 10000) {
      app.offerValue = 1000.00; // Oferta inicial
    } else if (app.votes > 15000) {
      app.offerValue = 5000.00;
    }
  }
}
