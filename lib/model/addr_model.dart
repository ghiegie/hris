class AddrModel {
  bool isMailAddr;
  AddrType addrType;
  String unitNo = "";
  String buildName = "";
  String buildNo = "";
  String blkLot = "";
  String street = "";
  String subd = "";
  String brgy = "";
  String muniCity = "";
  String prov = "";
  String zip = "";

  AddrModel(this.addrType, this.isMailAddr);

  static bool changeIsMailAddr(AddrModel obj) {
    print("Before: ${obj.isMailAddr}");
    try {
      obj.isMailAddr = !obj.isMailAddr;
      print("After: ${obj.isMailAddr}");
    } catch (_) {
      print("ERROR After: ${obj.isMailAddr}");
      return false;
    }
    return true;
  }

  static bool changeUnitNo(AddrModel obj, String txt) {
    print("Before: ${obj.isMailAddr}");
    try {
      obj.unitNo = txt;
      print("After: ${obj.unitNo}");
    } catch (_) {
      print("ERROR After: ${obj.unitNo}");
      return false;
    }
    
    return true;
  }

  static bool changeBuildName(AddrModel obj, String txt) {
    print("Before: ${obj.buildName}");
    try {
      obj.buildName = txt;
      print("After: ${obj.buildName}");
    } catch (_) {
      print("ERROR After: ${obj.buildName}");
      return false;
    }

    return true;
  }

  static bool changeBuildNo(AddrModel obj, String txt) {
    print("Before: ${obj.buildNo}");
    try {
      obj.buildNo = txt;
      print("After: ${obj.buildNo}");
    } catch (_) {
      print("ERROR After: ${obj.buildNo}");
      return false;
    }

    return true;
  }

  static bool changeBlkLot(AddrModel obj, String txt) {
    print("Before: ${obj.blkLot}");
    try {
      obj.blkLot = txt;
      print("After: ${obj.blkLot}");
    } catch (_) {
      print("ERROR After: ${obj.blkLot}");
      return false;
    }

    return true;
  }

  static bool changeStreet(AddrModel obj, String txt) {
    print("Before: ${obj.street}");
    try {
      obj.street = txt;
      print("After: ${obj.street}");
    } catch (_) {
      print("ERROR After: ${obj.street}");
      return false;
    }
    
    return true;
  }

  static bool changeSubd(AddrModel obj, String txt) {
    print("Before: ${obj.subd}");
    try {
      obj.subd = txt;
      print("After: ${obj.subd}");
    } catch (_) {
      print("ERROR After: ${obj.subd}");
      return false;
    }

    return true;
  }

  static bool changeBrgy(AddrModel obj, String txt) {
    print("Before: ${obj.brgy}");
    try {
      obj.brgy = txt;
      print("After: ${obj.brgy}");
    } catch (_) {
      print("ERROR After: ${obj.brgy}");
      return false;
    }

    return true;
  }

  static bool changeMuniCity(AddrModel obj, String txt) {
    print("Before: ${obj.muniCity}");
    try {
      obj.muniCity = txt;
      print("After: ${obj.muniCity}");
    } catch (_) {
      print("ERROR After: ${obj.muniCity}");
      return false;
    }

    return true;
  }

  static bool changeProv(AddrModel obj, String txt) {
    print("Before: ${obj.prov}");
    try {
      obj.prov = txt;
      print("After: ${obj.prov}");
    } catch (_) {
      print("ERROR After: ${obj.prov}");
      return false;
    }

    return true;
  }

  static bool changeZip(AddrModel obj, String txt) {
    print("Before: ${obj.zip}");
    try {
      obj.zip = txt;
      print("After: ${obj.zip}");
    } catch (_) {
      print("ERROR After: ${obj.zip}");
      return false;
    }

    return true;
  }

  static bool changeAddrType(AddrModel obj, AddrType addrType) {
    print("Before: ${obj.addrType}");
    try {
      obj.addrType = addrType;
      print("After: ${obj.addrType}");
    } catch (_) {
      print("ERROR After: ${obj.addrType}");
      return false;
    }

    return true;
  }
}

enum AddrType {
  Permanent(name: "Permanent"),
  Temporary(name: "Temporary"),
  Undefined(name: "Undefined");

  const AddrType({required this.name});

  final String name;
}