import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_store/menus.dart';
// import 'package:online_store/order.dart';
import 'package:online_store/sizing.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_store/checkout_page.dart';
import 'package:online_store/vouchers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Menus menus;
  late Vouchers vouchers;
  // late Order order;
  bool isDataLoaded = false;
  List<int> quantity = [0, 0, 0, 0];
  int totalHarga = 0;
  int totalMenu = 0;
  String voucher = 'Input Voucher';
  String voucherInputted = '';
  TextEditingController voucherController = TextEditingController();

  Future<Menus> getDataFromAPI() async {
    Uri url = Uri.parse('https://tes-mobile.landa.id/api/menus');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      Menus menus = menusFromJson(response.body);
      setState(() {
        isDataLoaded = true;
      });
      return menus;
    } else {
      return Menus(statusCode: response.statusCode, datas: []);
    }
  }

  Future<Vouchers> getVouchersFromAPI() async {
    Uri url = Uri.parse('https://tes-mobile.landa.id/api/vouchers');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      Vouchers vouchers = vouchersFromJson(response.body);
      // setState(() {
      //   isDataLoaded = true;
      // });
      return vouchers;
    } else {
      return Vouchers(statusCode: response.statusCode, datas: []);
    }
  }

  // Future<Order> sendDataToAPI(int diskon, int totalPesanan) async {
  //   Uri url = Uri.parse('https://tes-mobile.landa.id/api/order');
  //   var response = await http.post(url,
  //       body: jsonEncode(<String, Object>{
  //         "nominal_diskon": "${diskon}",
  //         "nominal_pesanan": "${totalPesanan}"
  //         // "items": [
  //         //   {"id": id[0], "harga": harga[0], "catatan": catatan[0]},
  //         //   {"id": id[1], "harga": harga[1], "catatan": catatan[1]},
  //         //   {"id": id[2], "harga": harga[2], "catatan": catatan[2]},
  //         //   {"id": id[3], "harga": harga[3], "catatan": catatan[3]}
  //         // ]
  //       }));

  //   if (response.statusCode == 200) {
  //     return order = orderFromJson(response.body);
  //   } else {
  //     return Order(nominalDiskon: '', nominalPesanan: '', items: []);
  //   }
  // }

  assignData() async {
    menus = await getDataFromAPI();
    vouchers = await getVouchersFromAPI();
  }

  resetData() {
    setState(() {
      quantity = [0, 0, 0, 0];
      totalHarga = 0;
      totalMenu = 0;
      voucher = 'Input Voucher';
      voucherInputted = '';
    });
  }

  // void _printLatestValue() {
  //   setState(() {
  //     voucherInputted = voucherController.text;
  //   });
  // }

  @override
  void initState() {
    // call function
    assignData();
    resetData();
    super.initState();
    // voucherController.addListener(_printLatestValue);
  }

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is removed from the
  //   // widget tree.
  //   voucherController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Sizing().init(context);

    void openVoucherDialog() {
      showModalBottomSheet(
          isScrollControlled: true,
          enableDrag: true,
          isDismissible: true,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8 * 2))),
          context: context,
          builder: (context) => Container(
                padding: EdgeInsets.only(
                    top: 16,
                    right: 16,
                    left: 16,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/voucher.svg',
                          color: Color(0xff009AAD),
                          width: Sizing.blockSizeHorizontal! * 10,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Punya kode voucher?',
                          style: TextStyle(
                              fontSize: Sizing.blockSizeHorizontal! * 5,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Masukkan kode voucher di sini',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: Sizing.blockSizeHorizontal! * 4,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      onChanged: (String str) {
                        setState(() {
                          voucherInputted = str;
                        });
                      },
                      controller: voucherController,
                      autofocus: true,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      voucherInputted.isNotEmpty
                          ? voucherInputted.toLowerCase() ==
                                  vouchers.datas[0].kode
                              ? 'Voucher Puas (Rp100.000)'
                              : voucherInputted.toLowerCase() ==
                                      vouchers.datas[1].kode
                                  ? 'Voucher Hemat (Rp10.000)'
                                  : 'Voucher salah'
                          : '',
                      style: TextStyle(
                          color: voucherInputted.toLowerCase() ==
                                  vouchers.datas[0].kode
                              ? const Color(0xff009AAD)
                              : voucherInputted.toLowerCase() ==
                                      vouchers.datas[1].kode
                                  ? const Color(0xff009AAD)
                                  : Colors.red,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (totalHarga >= 100000) {
                            if (voucherInputted.toLowerCase() == 'puas') {
                              setState(() {
                                totalHarga -= 100000;
                                voucher = 'Puas (Rp100.000)';
                                Navigator.pop(context);
                              });
                            } else if (voucherInputted.toLowerCase() ==
                                'hemat') {
                              setState(() {
                                totalHarga -= 10000;
                                voucher = 'Hemat (Rp10.000)';
                                Navigator.pop(context);
                              });
                            } else {
                              return;
                            }
                          } else if (totalHarga >= 10000) {
                            if (voucherInputted.toLowerCase() == 'puas') {
                              setState(() {
                                totalHarga = 0;
                                voucher = 'Puas (Rp100.000)';
                                Navigator.pop(context);
                              });
                            } else if (voucherInputted.toLowerCase() ==
                                'hemat') {
                              setState(() {
                                totalHarga -= 10000;
                                voucher = 'Hemat (Rp10.000)';
                                Navigator.pop(context);
                              });
                            } else {
                              return;
                            }
                          } else {
                            if (voucherInputted.toLowerCase() == 'puas') {
                              setState(() {
                                totalHarga = 0;
                                voucher = 'Puas (Rp100.000)';
                                Navigator.pop(context);
                              });
                            } else if (voucherInputted.toLowerCase() ==
                                'hemat') {
                              setState(() {
                                totalHarga = 0;
                                voucher = 'Hemat (Rp10.000)';
                                Navigator.pop(context);
                              });
                            } else {
                              return;
                            }
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xff009AAD))),
                        child: Text('Validasi Voucher'))
                  ],
                ),
              ));
    }

    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
            height: Sizing.blockSizeVertical! * 30,
            // padding: EdgeInsets.all(8 * 2),
            decoration: BoxDecoration(
              color: Color(0xffF6F6F6),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            ),
            child: Column(
              children: [
                Container(
                  height: Sizing.blockSizeVertical! * 8,
                  padding: EdgeInsets.all(8 * 2),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32)),
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Total Pesanan (${totalMenu} Menu)',
                                  style: TextStyle(
                                      fontSize: Sizing.blockSizeHorizontal! * 5,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                )
                              ],
                            ),
                            InkWell(
                                onTap: () {},
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Rp ${totalHarga}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: Color(0xff009AAD),
                                              fontSize:
                                                  Sizing.blockSizeHorizontal! *
                                                      5,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.5,
                                            )),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    // SvgPicture.asset(
                                    //   'assets/arrow_right.svg',
                                    //   color: Color(0xff2E2E2E),
                                    //   width: Sizing.blockSizeHorizontal! * 4,
                                    // ),
                                  ],
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: Sizing.blockSizeVertical! * 10,
                  padding: EdgeInsets.all(8 * 2),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32)),
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 1,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 202, 201, 201)),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/voucher.svg',
                                  color: Color(0xff009AAD),
                                  width: Sizing.blockSizeHorizontal! * 10,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Voucher',
                                  style: TextStyle(
                                      fontSize: Sizing.blockSizeHorizontal! * 5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                )
                              ],
                            ),
                            InkWell(
                                onTap: () {
                                  openVoucherDialog();
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(voucher,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: Color(0xff2E2E2E),
                                              fontSize:
                                                  Sizing.blockSizeHorizontal! *
                                                      4,
                                              fontWeight: FontWeight.normal,
                                              letterSpacing: 0.5,
                                            )),
                                    SizedBox(
                                      width: 8,
                                    ),
                                  ],
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: Sizing.blockSizeVertical! * 12,
                  padding: EdgeInsets.all(8 * 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 15.0,
                        spreadRadius: 5.0,
                        offset: Offset(
                          5.0,
                          5.0,
                        ),
                      )
                    ],
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/keranjang.svg',
                                  color: Color(0xff009AAD),
                                  width: Sizing.blockSizeHorizontal! * 10,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total Pembayaran',
                                      style: TextStyle(
                                          fontSize:
                                              Sizing.blockSizeHorizontal! * 3.5,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      'Rp ${totalHarga}',
                                      style: TextStyle(
                                          fontSize:
                                              Sizing.blockSizeHorizontal! * 5,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff009AAD)),
                                    )
                                  ],
                                )
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return CheckoutPage(
                                      menus: menus,
                                      quantity: quantity,
                                      totalHarga: totalHarga,
                                      totalMenu: totalMenu,
                                      voucher: voucher);
                                }));
                                // setState(() async {
                                //   order = await sendDataToAPI(10000, 30000);
                                // });
                                // print(order);
                              },
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return const Color(0xff009AAD);
                                    }
                                    return Color(0xff009AAD);
                                  },
                                ),
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      vertical: 8 * 1.5, horizontal: 8 * 4),
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8 * 10),
                                    side: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                              child: Text("Pesan Sekarang",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Colors.white,
                                        fontSize:
                                            Sizing.blockSizeHorizontal! * 4,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
        body: isDataLoaded
            ? SafeArea(
                child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListView.separated(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const Divider(
                          color: Colors.transparent,
                          height: 8 * 3,
                        ),
                        itemCount: menus.datas.length,
                        itemBuilder: (context, index) => Container(
                            height: Sizing.blockSizeVertical! * 12,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xffF6F6F6),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                  spreadRadius: -2.0,
                                  offset: Offset(
                                    2.0,
                                    2.0,
                                  ),
                                )
                              ],
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Image.network(
                                      menus.datas[index].gambar,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                      width: Sizing.blockSizeHorizontal! * 35,
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            menus.datas[index].nama,
                                            style: TextStyle(
                                                fontSize: Sizing
                                                        .blockSizeHorizontal! *
                                                    5,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            'Rp ${menus.datas[index].harga}',
                                            style: TextStyle(
                                                fontSize: Sizing
                                                        .blockSizeHorizontal! *
                                                    4,
                                                color: Color(0xff009AAD),
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            'Tambahkan catatan',
                                            style: TextStyle(
                                                fontSize: Sizing
                                                        .blockSizeHorizontal! *
                                                    3,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    width: Sizing.blockSizeHorizontal! * 25,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                quantity[index] -= 1;
                                                totalHarga -=
                                                    menus.datas[index].harga;
                                                totalMenu -= 1;
                                              });
                                            },
                                            child: Icon(Icons.remove,
                                                size: Sizing
                                                        .blockSizeHorizontal! *
                                                    7,
                                                color: Color(0xff009AAD)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          '${quantity[index]}',
                                          style: TextStyle(
                                              fontSize:
                                                  Sizing.blockSizeHorizontal! *
                                                      6),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                quantity[index] += 1;
                                                totalHarga +=
                                                    menus.datas[index].harga;
                                                totalMenu += 1;
                                              });
                                            },
                                            child: Icon(Icons.add,
                                                size: Sizing
                                                        .blockSizeHorizontal! *
                                                    7,
                                                color: Color(0xff009AAD)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff009AAD))),
                          onPressed: () {
                            setState(() {
                              quantity = [0, 0, 0, 0];
                              totalHarga = 0;
                              totalMenu = 0;
                              voucher = 'Input Voucher';
                            });
                          },
                          child: Text('Reset'))
                    ],
                  ),
                ),
              ))
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
