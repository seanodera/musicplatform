// ignore_for_file: file_names

class Payments {
  String apiKey = '', secret = '', endpoint = '';

  bool addCard(CreditCard card) {
    return true;
  }
}

class CreditCard {
  int cardNumber, cvc, monthExpiry, yearExpiry;
  String name;
  CreditCard(
      {required this.cardNumber,
      required this.name,
      required this.monthExpiry,
      required this.yearExpiry,
      required this.cvc});
}
