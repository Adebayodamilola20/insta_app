import 'package:flutter/material.dart';

class OfferModel {
  final String productTitle;
  final String offeredPrice;
  final String sellingPrice;
  final String imageUrl;
  final String location;
  final DateTime submissionTime;
  final Duration originalDuration;

  OfferModel({
    required this.productTitle,
    required this.offeredPrice,
    required this.sellingPrice,
    required this.imageUrl,
    required this.location,
    required this.submissionTime,
    required this.originalDuration,
  });
}