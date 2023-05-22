import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_store/home_page.dart';
import 'package:online_store/menus.dart';
import 'package:online_store/sizing.dart';

class CheckoutPage extends StatefulWidget {
  final Menus menus;
  List<int> quantity;
  int totalHarga;
  int totalMenu;
  String voucher;
  CheckoutPage(
      {super.key,
      required this.menus,
      required this.quantity,
      required this.totalHarga,
      required this.totalMenu,
      required this.voucher});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    Sizing().init(context);

    void openDialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/warning.svg',
                      width: Sizing.blockSizeHorizontal! * 12,
                      color: Color(0xff009AAD),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    SizedBox(
                        width: Sizing.blockSizeHorizontal! * 50,
                        child: Text(
                          'Apakah Anda yakin ingin membatalkan pesanan ini?',
                          maxLines: 4,
                          style: TextStyle(
                              fontSize: Sizing.blockSizeHorizontal! * 4.5,
                              fontWeight: FontWeight.w400),
                        ))
                  ],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                content: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 8 * 1.5, horizontal: 8 * 4),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8 * 10),
                            side: BorderSide(
                              color: Color(0xff009AAD),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      child: Text("Tidak",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Color(0xff009AAD),
                                    fontSize: Sizing.blockSizeHorizontal! * 4,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  )),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return HomePage();
                        }));
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
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
                      child: Text("Yakin",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontSize: Sizing.blockSizeHorizontal! * 4,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  )),
                    )
                  ],
                ),
              ));
    }

    return Scaffold(
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
                                  'Total Pesanan (${widget.totalMenu} Menu)',
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
                                    Text("Rp ${widget.totalHarga}",
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
                                  // openDialog();
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        widget.voucher == 'Input Voucher'
                                            ? 'Tanpa Voucher'
                                            : widget.voucher,
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
                                      'Rp ${widget.totalHarga}',
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
                                openDialog();
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
                              child: Text("Batalkan",
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
        body: SafeArea(
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
                  itemCount: widget.menus.datas.length,
                  itemBuilder: (context, index) => Opacity(
                    opacity: widget.quantity[index] > 0 ? 1.0 : 0.5,
                    child: Container(
                        height: Sizing.blockSizeVertical! * 12,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: widget.quantity[index] > 0
                              ? Color(0xffF6F6F6)
                              : Color.fromARGB(255, 202, 202, 202),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Image.network(
                                  widget.menus.datas[index].gambar,
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
                                        widget.menus.datas[index].nama,
                                        style: TextStyle(
                                            fontSize:
                                                Sizing.blockSizeHorizontal! * 5,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        'Rp ${widget.menus.datas[index].harga}',
                                        style: TextStyle(
                                            fontSize:
                                                Sizing.blockSizeHorizontal! * 4,
                                            color: Color(0xff009AAD),
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'Tambahkan catatan',
                                        style: TextStyle(
                                            fontSize:
                                                Sizing.blockSizeHorizontal! * 3,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                width: Sizing.blockSizeHorizontal! * 25,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // SizedBox(
                                    //   width: 24,
                                    //   height: 24,
                                    //   child: InkWell(
                                    //     onTap: () {
                                    //       setState(() {
                                    //         quantity[index] -= 1;
                                    //         totalHarga -= menus.datas[index].harga;
                                    //         totalMenu -= 1;
                                    //       });
                                    //     },
                                    //     child: Icon(Icons.remove,
                                    //         size: Sizing.blockSizeHorizontal! * 7,
                                    //         color: Color(0xff009AAD)),
                                    //   ),
                                    // ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      '${widget.quantity[index]}',
                                      style: TextStyle(
                                          fontSize:
                                              Sizing.blockSizeHorizontal! * 6),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    // SizedBox(
                                    //   width: 24,
                                    //   height: 24,
                                    //   child: InkWell(
                                    //     onTap: () {
                                    //       setState(() {
                                    //         quantity[index] += 1;
                                    //         totalHarga += menus.datas[index].harga;
                                    //         totalMenu += 1;
                                    //       });
                                    //     },
                                    //     child: Icon(Icons.add,
                                    //         size: Sizing.blockSizeHorizontal! * 7,
                                    //         color: Color(0xff009AAD)),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                // ElevatedButton(
                //     onPressed: () {
                //       setState(() {
                //         quantity = [0, 0, 0, 0];
                //         totalHarga = 0;
                //         totalMenu = 0;
                //         voucher = 'Input Voucher';
                //       });
                //     },
                //     child: Text('Reset'))
              ],
            ),
          ),
        )));
  }
}
