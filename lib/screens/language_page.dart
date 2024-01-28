import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liveasy_assignment/constants/color.dart';
import 'package:liveasy_assignment/constants/route_generator.dart';
import 'package:liveasy_assignment/widgets/custom_button.dart';

class LanguagePage extends StatelessWidget {
  LanguagePage({super.key});
  String selectedCountry = 'English';
  List<DropdownMenuItem<String>> countriesName = ['English',]
      .map(
        (name) => DropdownMenuItem(
          value: name,
          child: Text(name),
        ),
      )
      .toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 120),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Image(
                        height: 100,
                        width: 100,
                        image: AssetImage('assets/gallery.png'),
                      ),
                      const SizedBox(height: 42,),
                      const Text(
                        'Please select your Language',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'You can change the language \n at any time.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.lightGrey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      DropdownButtonFormField(
                        isExpanded: true,
                        decoration: const InputDecoration(
                          isDense: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        value: selectedCountry,
                        items: countriesName,
                        onChanged: (value) {
                          selectedCountry = value!;
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      CustomButton(
                          text: 'NEXT',
                          onTap: () async{
                            await FirebaseAuth.instance.signOut();
                           Navigator.pushNamed(
                                context, RouteGenerator.numberPage);
                          })
                    ]),
              ),
            ),
            Image(
              image: const AssetImage('assets/page1.png'),
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
          ],
        ),
      ),
    );
  }
}
