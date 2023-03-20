part of '../new_clock_screen.dart';

class _TimerInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const _TimerInputWidget(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.labelLarge;
    return SizedBox(
      width: (2 * (textTheme?.fontSize ?? 16)),
      child: TextField(
        controller: controller,
        maxLength: 2,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          if ((int.tryParse(value) ?? 0) > 60) {
            controller.text = "59";
          }
        },
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
