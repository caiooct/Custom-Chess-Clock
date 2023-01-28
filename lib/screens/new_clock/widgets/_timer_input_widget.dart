part of '../new_clock_screen.dart';

class _TimerInputWidget extends StatelessWidget {
  const _TimerInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.labelLarge;
    return SizedBox(
      width: (2 * (textTheme?.fontSize ?? 16)),
      child: TextField(
        maxLength: 2,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textAlign: TextAlign.center,
        style: textTheme,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(top: 4, bottom: 4, left: 1),
          isDense: true,
          hintText: "00",
          counterText: '',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
