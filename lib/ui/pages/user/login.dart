import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loyalty/ui/components/phone_number_input.dart';
import 'package:loyalty/ui/components/primaryButton.dart';
import 'package:loyalty/ui/components/primaryTextField.dart';
import 'package:loyalty/ui/pages/user/qr_code.dart';
import 'package:loyalty/utils/colors.dart';
import 'package:loyalty/utils/text.dart';
import 'package:loyalty/utils/typography.dart';
import 'package:loyalty/utils/utils.dart';

final tapCounter = StateProvider<int>((ref) => 0);

class UserLoginViewModel {
  String? qrCode;
  String? phoneNumber;

  bool get isReady => qrCode != null && phoneNumber != null;
}

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  UserLoginViewModel viewModel = UserLoginViewModel();
  final Debouncer _debouncer = Debouncer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(tapCounter.notifier).stream.listen((event) {
        if (event >= 5) {
          showAdminLoginDialog();
        }
      });
    });
  }

  Future<void> showAdminLoginDialog() async {
    showDialog(
        context: context,
        barrierColor: Colors.black.withOpacity(0.1),
        builder: (context) => const AdminDialogue());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: LoyaltiColor.white,
        elevation: 0,
        title: GestureDetector(
          onTap: () {
            if (ref.read(tapCounter.notifier).state == 5) return;
            ref.read(tapCounter.notifier).state++;

            _debouncer.run(() {
              ref.read(tapCounter.notifier).state = 0;
            });
          },
          child: RichText(
              text: TextSpan(children: [
            TextSpan(text: "Loyalt", style: LoyaltiTypography.title(fontSize: 40)),
            TextSpan(
                text: "i",
                style: LoyaltiTypography.title(fontSize: 40, color: LoyaltiColor.accent)),
          ])),
        ),
      ),
      backgroundColor: LoyaltiColor.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Login", style: LoyaltiTypography.title(fontSize: 25)),
                const SizedBox(height: 15),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: buildForm(),
                  ),
                ),
                PrimaryButtonWidget(
                  isEnabled: viewModel.isReady,
                  title: "Continue",
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            final result = await Navigator.push(
                context, materialRoute(const QRCodeScanner(), routeName: "QR code scanner"));

            if (result is! String) return;
            viewModel.qrCode = result;
            setState(() {});
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: LoyaltiColor.offWhite,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(color: LoyaltiColor.accent, width: 3),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/svg/qrcode-icon.svg",
                        width: 30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                LoyaltiText.bodyText(
                    viewModel.qrCode == null ? "Tap here to scan QR code" : "QR code is ready"),
                const Spacer(),
                if (viewModel.qrCode != null)
                  IconButton(
                      onPressed: () {
                        viewModel.qrCode = null;
                        setState(() {});
                      },
                      icon: const Icon(Icons.close))
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        PhoneNumberField(onChanged: (phone) {
          viewModel.phoneNumber = phone.phoneNumber;
          setState(() {});
        })
      ],
    );
  }
}

class AdminDialogue extends StatelessWidget {
  const AdminDialogue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 350,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              LoyaltiText.sectionTitle("Admin Login"),
              const SizedBox(height: 20),
              const PrimaryTextFieldWidget(hintText: "Username"),
              const SizedBox(height: 10),
              const PrimaryTextFieldWidget(
                hintText: "Password",
                obscureText: true,
              ),
              const SizedBox(height: 30),
              PrimaryButtonWidget(title: "Login")
            ],
          ),
        ),
      ),
    );
  }
}
