import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mykuaforshop/services/db.dart';
import 'package:mykuaforshop/services/shared_pref.dart';

class Booking extends StatefulWidget {
  String service;
  Booking({required this.service});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String? name, image, email, phone;

  getthedatafromsharedpref() async {
    name = await SharedpreferenceHelper().getUserName();
    image = await SharedpreferenceHelper().getUserImage();
    email = await SharedpreferenceHelper().getUserEmail();
    phone = await SharedpreferenceHelper().getUserPhone();
    setState(() {});
  }

  getontheload() async {
    await getthedatafromsharedpref();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2024),
        lastDate: DateTime(2025));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  TimeOfDay _selectedTime = TimeOfDay.now();
  List<TimeOfDay> _appointments = [];

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _selectedTime);
    if (picked != null && picked != _selectedTime) {
      // Barber çalışma saatlerini kontrol etme fonksiyonu  (9.00 ile 22.00 arası)
      if (picked.hour >= 9 && picked.hour <= 22) {
        // Mevcut randevuları aynı anda kontrol etme
        if (!_appointments.contains(picked)) {
          setState(() {
            _selectedTime = picked;
            _appointments.add(picked);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Randevu saati başarıyla seçildi: ${picked.format(context)}')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Bu saat için zaten bir randevu var.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Randevu saatleri sadece 9.00 ile 22.00 arasında olmalıdır.')),
        );
      }
    }
  }

  Future<void> _checkAndBookAppointment(BuildContext context) async {
    // Kullanıcının aynı hizmet için seçilen tarihte randevusu olup olmadığını kontrol et
    bool alreadyBooked = await DatabaseMethods().checkUserBooking(
      email!,
      widget.service,
      "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}", phone!
    );

    if (alreadyBooked) {
      // Eğer zaten randevusu varsa, kullanıcıya mesaj göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bu hizmet için bu tarihte zaten bir randevunuz var.'),
        ),
      );
    } else {
      // Eğer randevusu yoksa, yeni randevu oluştur
      Map<String, dynamic> userBookingmap = {
        "Servis": widget.service,
        "Randevu_Tarihi":
            "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}"
                .toString(),
        "Randevu_Saati": _selectedTime.format(context),
        "Ad_Soyad": name,
        "Profil_Resimi": image,
        "Phone": phone,
        "E_posta": email,
      };
      await DatabaseMethods().addUserBooking(userBookingmap).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Randevunuz başarıyla oluşturuldu.",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Container(
        margin: EdgeInsets.only(left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color.fromARGB(255, 94, 138, 241),
                  size: 30.0,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              "Hadi\nbaşlayalım ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "images/discount.png",
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 10.0,
            ),
            Text(
              widget.service,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 36, 89, 108),
                  borderRadius: BorderRadius.circular(20.0)),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    "Tarih Belirleyin",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Text(
                        "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 36, 89, 108),
                  borderRadius: BorderRadius.circular(20.0)),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    "Saati Belirleyin",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _selectTime(context);
                        },
                        child: Icon(
                          Icons.alarm,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                      SizedBox(width: 15.0),
                      Text(
                        _selectedTime.format(context),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                Map<String, dynamic> userBookingmap = {
                  "Servis": widget.service,
                  "Randevu_Tarihi":
                      "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}"
                          .toString(),
                  "Randevu_Saati": _selectedTime.format(context),
                  "Ad_Soyad": name,
                  "Profil_Resimi": image,
                  "E_posta": email,
                };
                await DatabaseMethods()
                    .addUserBooking(userBookingmap)
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    "Randevunuz başarıyla oluşturuldu.",
                    style: TextStyle(fontSize: 20.0),
                  )));
                });
              },
              child: GestureDetector(
                onTap: () {
                  _checkAndBookAppointment(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                  decoration: BoxDecoration(
                      color: Color(0xFFfe8f33),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Center(
                    child: Text(
                      "Randevu Al",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
