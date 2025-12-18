import 'package:flutter/material.dart';
import 'package:insta_app/models/offer_model.dart';

class OfferProvider extends ChangeNotifier {
  final List<OfferModel> _userOffers = [];

  List<OfferModel> get userOffers => _userOffers;

  void addOffer(OfferModel offer) {
    _userOffers.add(offer);
    notifyListeners();
  }
}