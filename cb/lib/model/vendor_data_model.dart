class Vendor {
  int id;
  final String documentId;
  final String profession;
  final String photoId;
  final String signatureImage;
  final String educationalDocument;
  final String name;
  final String speciality;
  final String firmName;
  final String address;
  final String charges;
  final String mobile;
  final String email;

  Vendor({
    this.id = 0,
    required this.documentId,
    required this.profession,
    required this.photoId,
    required this.signatureImage,
    required this.educationalDocument,
    required this.name,
    required this.speciality,
    required this.firmName,
    required this.address,
    required this.charges,
    required this.mobile,
    required this.email,
  });

  static Vendor fromJson(String id, Map<String, dynamic> json) => Vendor(
        documentId: id,
        profession: json['profession'],
        photoId: json['photoId'] ?? '',
        signatureImage: json['signatureImage'] ?? '',
        educationalDocument: json['educationalDocument'] ?? '',
        name: json['name'],
        speciality: json['speciality'],
        firmName: json['firm_name'],
        address: json['address'],
        charges: json['charges'],
        mobile: json['mobile'],
        email: json['email'],
      );
}
