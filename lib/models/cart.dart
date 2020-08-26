class Cart {
  final String cartId;
  final String date;

  Cart({this.cartId, this.date});

  Map<String, dynamic> toMap() {
    return {'cartId': cartId, 'date': date};
  }

  Cart.fromFirestore(Map<String, dynamic> firestore)
      : cartId = firestore['cartId'],
        date = firestore['date'];
}
