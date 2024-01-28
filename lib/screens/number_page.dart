import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:liveasy_assignment/constants/color.dart';
import 'package:liveasy_assignment/constants/route_generator.dart';
import 'package:liveasy_assignment/widgets/custom_button.dart';

class NumberPage extends StatefulWidget {
  NumberPage({super.key});

  @override
  State<NumberPage> createState() => _NumberPageState();
}

class _NumberPageState extends State<NumberPage> {
  TextEditingController _numberController = TextEditingController();

  final _form = GlobalKey<FormState>();
  String countryCode = "+91";

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Please enter your mobile number',
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
                      'You’ll receive a 6 digit code \n to verify next.',
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
                    Form(
                      key: _form,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: InternationalPhoneNumberInput(
                          onInputChanged: (value) {
                            countryCode = value.dialCode!;
                          },
                          formatInput: false,
                          initialValue: PhoneNumber(
                              phoneNumber: "+91",
                              dialCode: "+91",
                              isoCode: "IN"),
                          validator: (value) => value!.isEmpty
                              ? "Enter mobile number"
                              : value.length != 10
                                  ? "Enter correct number"
                                  : null,
                          ignoreBlank: true,
                          textFieldController: _numberController,
                          hintText: 'Mobile Number',
                          cursorColor: AppColors.darkBlue,
                          inputBorder: InputBorder.none,
                          keyboardType: const TextInputType.numberWithOptions(
                            signed: true,
                            decimal: true,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomButton(
                        text: 'CONTINUE',
                        onTap: () async {
                          if (_form.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            await FirebaseAuth.instance.verifyPhoneNumber(
                                verificationCompleted:
                                    (PhoneAuthCredential phoneAuthCredential) {
                                  setState(() {
                                    debugPrint(
                                        "Your account is successfully verified");
                                  });
                                },
                                verificationFailed: (FirebaseAuthException ex) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Verification Failed, try again later!',
                                      ),
                                    ),
                                  );
                                },
                                codeSent: (String verificationId,
                                    [resendToken]) {
                                  Navigator.pushNamed(
                                      context, RouteGenerator.verificationPage,
                                      arguments: {
                                        "number":
                                            _numberController.text.toString(),
                                        "verifyId": verificationId,
                                      });
                                },
                                codeAutoRetrievalTimeout: (verificationId) {},
                                timeout: const Duration(seconds: 120),
                                phoneNumber:
                                    '$countryCode${_numberController.text.trim()}');
                          }
                        }),
                  ],
                ),
              ),
            ),
            Image(
              image: const AssetImage('assets/footer.png'),
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
          ]),
    );
  }
}
