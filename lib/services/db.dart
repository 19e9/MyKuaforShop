import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future addUserBooking(Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("Booking")
        .add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getBookings() async {
    return await FirebaseFirestore.instance.collection("Booking").snapshots();
  }

  Future DeleteBooking(String id) async {
    return await FirebaseFirestore.instance
        .collection("Booking")
        .doc(id)
        .delete();
  }

  Future<bool> checkUserBooking(
      String email, String phone, String service, String date,) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Booking')
          .where('E_posta', isEqualTo: email)
          .where('Phone', isEqualTo: phone)
          .where('Servis', isEqualTo: service)
          .where('Randevu_Tarihi', isEqualTo: date)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking user booking: $e');
      return false;
    }
  }

  Future<Stream<QuerySnapshot>> getBooking() async {
    return await FirebaseFirestore.instance.collection("Booking").snapshots();
  }
}
