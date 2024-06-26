import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mykuaforshop/pages/booking.dart';
import 'package:mykuaforshop/services/shared_pref.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? name, image;

  getthedatafromsharedpref() async {
    name = await SharedpreferenceHelper().getUserName();
    image = await SharedpreferenceHelper().getUserImage();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Container(
        margin: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Merhaba,",
                      style: TextStyle(
                          color: Color(0xFF04526F),
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      name ?? "",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      image ?? "",
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ))
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Divider(
              color: Colors.black26,
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              "Servisler",
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Booking(service: 'Traş')));
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: Color(0xFF04526F),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/shaving.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Traş",
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Booking(service: 'Saç Yıkaması')));
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: Color(0xFF04526F),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/hair.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Saç Yıkaması",
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Booking(service: 'Saç Kesimi')));
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: Color(0xFF04526F),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/cutting.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Saç Kesimi",
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Booking(service: 'Sakal Kesimi')));
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: Color(0xFF04526F),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/beard.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Sakal Kesimi",
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Booking(service: 'Yüz Bakımı')));
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: Color(0xFF04526F),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/facials.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Yüz Bakımı",
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Booking(service: 'Çocuk Saç Kesimi')));
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: Color(0xFF04526F),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/kids.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Çocuk Saç Kesimi",
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
