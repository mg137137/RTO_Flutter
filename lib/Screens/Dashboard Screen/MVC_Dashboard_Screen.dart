class MVC_Dashboard_Screen {
  String? MVC_Variable_VehicleID;
  String? MVC_Variable_VehcleNumber;
  String? MVC_Variable_Delar_OR_Customer;

  MVC_Dashboard_Screen(
      {this.MVC_Variable_VehicleID,
      this.MVC_Variable_VehcleNumber,
      this.MVC_Variable_Delar_OR_Customer});

  MVC_Dashboard_Screen.fromJson(Map<String, dynamic> json) {
    MVC_Variable_VehicleID = json['vehicleRegistrationId'];
    MVC_Variable_VehcleNumber = json['vehicleRegistrationNumber'];
    MVC_Variable_Delar_OR_Customer = json['Dealer/Customer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['vehicleRegistrationNumber'] = this.MVC_Variable_VehcleNumber;
    data['vehicleRegistrationId'] = this.MVC_Variable_VehicleID;
    data['Dealer/Customer'] = this.MVC_Variable_Delar_OR_Customer;

    return data;
  }
}
