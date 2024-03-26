String formatToReais(double value) {
  String formattedString = value.toStringAsFixed(2);

  var [wholeNumber, decimalNumber] = formattedString.split('.');

  String integerPart = '';
  int count = 0;
  for (int i = wholeNumber.length - 1; i >= 0; i--) {
    if (count != 0 && count % 3 == 0) {
      integerPart = '.$integerPart';
    }
    integerPart = wholeNumber[i] + integerPart;
    count++;
  }

  return '$integerPart,$decimalNumber';
}

String convertDate(DateTime data) {
  return '${data.day}/${data.month}/${data.year}';
}

