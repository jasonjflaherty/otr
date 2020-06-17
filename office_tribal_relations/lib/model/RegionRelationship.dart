class RegionalRelationships {
  RegionName r1R4;
  RegionName r10;
  RegionName r2;
  RegionName r3;
  RegionName r4;
  RegionName r5;
  RegionName r8;
  RegionName r9;

  RegionalRelationships(
      {this.r1R4,
      this.r10,
      this.r2,
      this.r3,
      this.r4,
      this.r5,
      this.r8,
      this.r9});

  RegionalRelationships.fromJson(Map<String, dynamic> json) {
    r1R4 =
        json['R1/R4'] != null ? new RegionName.fromJson(json['R1/R4']) : null;
    r10 = json['R10'] != null ? new RegionName.fromJson(json['R10']) : null;
    r2 = json['R2'] != null ? new RegionName.fromJson(json['R2']) : null;
    r3 = json['R3'] != null ? new RegionName.fromJson(json['R3']) : null;
    r4 = json['R4'] != null ? new RegionName.fromJson(json['R4']) : null;
    r5 = json['R5'] != null ? new RegionName.fromJson(json['R5']) : null;
    r8 = json['R8'] != null ? new RegionName.fromJson(json['R8']) : null;
    r9 = json['R9'] != null ? new RegionName.fromJson(json['R9']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.r1R4 != null) {
      data['R1/R4'] = this.r1R4.toJson();
    }
    if (this.r10 != null) {
      data['R10'] = this.r10.toJson();
    }
    if (this.r2 != null) {
      data['R2'] = this.r2.toJson();
    }
    if (this.r3 != null) {
      data['R3'] = this.r3.toJson();
    }
    if (this.r4 != null) {
      data['R4'] = this.r4.toJson();
    }
    if (this.r5 != null) {
      data['R5'] = this.r5.toJson();
    }
    if (this.r8 != null) {
      data['R8'] = this.r8.toJson();
    }
    if (this.r9 != null) {
      data['R9'] = this.r9.toJson();
    }
    return data;
  }
}

class RegionName {
  List<RegionData> regionData;

  RegionName({this.regionData});

  RegionName.fromJson(Map<String, dynamic> json) {
    if (json['RegionData'] != null) {
      regionData = new List<RegionData>();
      json['RegionData'].forEach((v) {
        regionData.add(new RegionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.regionData != null) {
      data['RegionData'] = this.regionData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RegionData {
  String tribes;
  String state;
  String forest;

  RegionData({this.tribes, this.state, this.forest});

  RegionData.fromJson(Map<String, dynamic> json) {
    tribes = json['Tribes'];
    state = json['State'];
    forest = json['Forest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Tribes'] = this.tribes;
    data['State'] = this.state;
    data['Forest'] = this.forest;
    return data;
  }
}
