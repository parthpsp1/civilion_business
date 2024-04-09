class Vendor {
  int id;
  final String profession;
  final String name;
  final String speciality;
  final String firmName;
  final String address;
  final String charges;
  final String mobile;
  final String email;

  Vendor({
    this.id = 0,
    required this.profession,
    required this.name,
    required this.speciality,
    required this.firmName,
    required this.address,
    required this.charges,
    required this.mobile,
    required this.email,
  });

  static Vendor fromJson(Map<String, dynamic> json) => Vendor(
        profession: json['profession'],
        name: json['name'],
        speciality: json['speciality'],
        firmName: json['firm_name'],
        address: json['address'],
        charges: json['charges'],
        mobile: json['mobile'],
        email: json['email'],
      );
}
