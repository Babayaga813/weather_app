import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
          TypewriterAnimatedText("Hey There!!",
              textStyle: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.dancingScript().fontFamily))
        ]),
        30.verticalSpace,
        AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
          TypewriterAnimatedText("Fetching data please wait..",
              textStyle:
                  TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500))
        ]),
        50.verticalSpace,
        LoadingAnimationWidget.inkDrop(color: const Color(0xff1c1c1c), size: 40)
      ],
    );
  }
}
