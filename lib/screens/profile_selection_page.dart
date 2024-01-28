import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liveasy_assignment/constants/color.dart';
import 'package:liveasy_assignment/widgets/custom_button.dart';

class ProfileSelectionPage extends StatefulWidget {
  ProfileSelectionPage({super.key});

  @override
  State<ProfileSelectionPage> createState() => _ProfileSelectionPageState();
}

class _ProfileSelectionPageState extends State<ProfileSelectionPage> {
  String? transport = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // actions: [
        //   IconButton(
        //     onPressed: () async {
        //       await FirebaseAuth.instance.signOut();
        //     },
        //     icon: const Icon(Icons.logout_outlined),
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Please select your profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    transport = "shipper";
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        value: "shipper",
                        groupValue: transport,
                        activeColor: AppColors.darkBlue,
                        onChanged: (value) {
                          setState(() {
                            transport = value;
                          });
                        }),
                    const Image(
                      image: AssetImage('assets/shipper.png'),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shipper',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing',
                            softWrap: true,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    transport = "transpoter";
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        value: "transpoter",
                        groupValue: transport,
                        activeColor: AppColors.darkBlue,
                        onChanged: (value) {
                          setState(() {
                            transport = value;
                          });
                        }),
                    const Image(
                      image: AssetImage('assets/transpoter.png'),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Transporter',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing',
                            softWrap: true,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            CustomButton(text: 'CONTINUE', onTap: () {})
          ],
        ),
      ),
    );
  }
}
