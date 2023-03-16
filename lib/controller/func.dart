abstract class Func {
  Func._();

  static isAlpha(
    String name,
  ) {
    bool z = false;
    List l = [" "];
    String s = " `~1234567890!@#\$%^&*()|:\"<>?/,{}[]=-_+";
    for (int i = 0; i < s.length; i++) {
      l.add(s[i]);
    }
    for (int i = 0; i < name.length; i++) {
      for (int j = 0; j < l.length; j++) {
        if (name[i] == l[j]) {
          z = name[i] == l[j];
          break;
        }
      }
    }
    return z;
  }

  static cardNum(String cardNum) {
    //String res=cardNum.substring(0,3);
    Map dicCard = {
      "5425": "assets/masterc.png",
      "2222": "assets/masterc.png",
      "2223": "assets/masterc.png",
      "4263": "assets/visa4.png",
      "4917": "assets/visa4.png",
      "4000": "assets/visa4.png",
      "4007": "assets/visa4.png",
      "9860": "assets/humo.png",
      "8600": "assets/Uzcard.png",
    };
    //String res=cardNum.substring(0,4);
    return dicCard[cardNum];
  }
}

class CardUtils {
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return Errors.fieldReq;
    }

    int year;
    int month;
    // The value contains a forward slash if the month and year has been
    // entered.
    if (value.contains(RegExp(r'(/)'))) {
      var split = value.split(RegExp(r'(/)'));
      // The value before the slash is the month while the value to right of
      // it is the year.
      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      // Only the month was entered
      month = int.parse(value.substring(0, (value.length)));
      year = -1; // Lets use an invalid year intentionally
    }

    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      return "Muddatni to'g'ri Kiriting";
    }

    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      return 'Expiry year is invalid';
    }

    if (!hasDateExpired(month, year)) {
      return "Card has expired";
    }
    return null;
  }

  /// Convert the two-digit year to four-digit year if necessary
  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static List<int> getExpiryDate(String value) {
    var split = value.split(RegExp(r'(/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }

  static String getCleanedNumber(String text) {
    RegExp regExp = RegExp(r"\D");
    return text.replaceAll(regExp, '');
  }

  static String? validateCardNum(String? input) {
    if (input == null || input.isEmpty) {
      return Errors.fieldReq;
    }

    if (!RegExp(r"^[\d -' ']{19}$").hasMatch(input)) {
      return Errors.numberIsInvalid;
    } else {
      return null;
    }
  }

  static String? validateEmpty(String? input) {
    if (input == null || input.isEmpty) {
      return Errors.fieldReq;
    } else {
      return null;
    }
  }

  static CardType getCardTypeFrmNumber(String input) {
    CardType cardType;
    if (input.startsWith(RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardType.Master;
    } else if (input.startsWith(RegExp(r'[4]'))) {
      cardType = CardType.Visa;
    } else if (input.startsWith(RegExp(r'((9860(0|1))|(507(8|9))|(6500))'))) {
      cardType = CardType.humo;
    } else if (input.startsWith(RegExp(r'((86)|(00))'))) {
      cardType = CardType.uzCard;
    } else {
      cardType = CardType.Others;
    }
    return cardType;
  }
}

class Errors {
  static const String fieldReq = 'Muddatni kiritish majburiy';
  static const String numberIsInvalid = 'Card is invalid';
  static const String moneyIsScarce = 'money is scarce';
}

enum CardType {
  // ignore: constant_identifier_names
  Master,
  // ignore: constant_identifier_names
  Visa,
  humo,
  uzCard,
  // ignore: constant_identifier_names
  Others,
}
