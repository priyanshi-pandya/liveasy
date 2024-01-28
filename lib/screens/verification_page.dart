import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liveasy_assignment/constants/color.dart';
import 'package:liveasy_assignment/constants/route_generator.dart';
import 'package:liveasy_assignment/widgets/custom_button.dart';
import 'package:sms_autofill/sms_autofill.dart';
// import 'package:pinput/pinput.dart';



class VerificationPage extends StatefulWidget {
  const VerificationPage({
    super.key,
    required this.number,
    required this.verificationId,
  });
  final String number;
  final String verificationId;

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _form = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();

  

  @override
  void dispose() {
    otpController.dispose();
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  getAppSignature() async{
    await SmsAutoFill().getAppSignature.then((value) async{
      await SmsAutoFill().listenForCode();
    });
  }
  @override
  void initState() {
    super.initState();
    getAppSignature();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
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
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Verify Phone',
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
                  Text(
                    'Code is sent to ${widget.number}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
                    child: PinFieldAutoFill(
                        decoration: BoxLooseDecoration(
                          radius: Radius.circular(0),
                          gapSpace: 8,
                          strokeColorBuilder: PinListenColorBuilder(Colors.white, Colors.white),
                          bgColorBuilder: const FixedColorBuilder(AppColors.lightBlue),
                          strokeWidth: 0,
                        ),
                        autoFocus: true,
                        cursor: Cursor(color:AppColors.darkBlue, enabled: true, width: 1),
                        currentCode: '',
                        onCodeSubmitted: (code) {},
                        codeLength: 6,
                        onCodeChanged: (code) {
                          print(code);
                        },

                      ),
                    //  Pinput(
                    //   controller: otpController,
                    //   length: 6,
                    //   defaultPinTheme: const PinTheme(
                    //     height: 48,
                    //     width: 48,
                    //     decoration: BoxDecoration(
                    //       color: AppColors.lightBlue,
                    //     ),
                    //   ),
                    //   androidSmsAutofillMethod:
                    //       AndroidSmsAutofillMethod.smsRetrieverApi,
                    //   pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    //   showCursor: true,
                    //   onCompleted: (pin) => print(pin),
                    // ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      text: 'Didn’t receive the code? ',
                      style: TextStyle(
                        color: AppColors.lightGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: 'Request Again',
                          style: TextStyle(
                            color: AppColors.lightBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomButton(
                      text: 'VERIFY AND CONTINUE',
                      onTap: () async {
                        if (_form.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          try {
                            PhoneAuthCredential phoneAuthCredential =
                                PhoneAuthProvider.credential(
                                    verificationId: widget.verificationId,
                                    smsCode: otpController.text);
                            FirebaseAuth.instance
                                .signInWithCredential(phoneAuthCredential)
                                .then((value) => Navigator.pushNamed(context,
                                    RouteGenerator.profileSelectionPage));
                          } catch(e) {
                            debugPrint(e.runtimeType.toString());
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  e.toString(),
                                ),
                              ),
                            );
                          };
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
        ],
      ),
    );
  }
}
