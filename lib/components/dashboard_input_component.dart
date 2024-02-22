// ignore_for_file: must_be_immutable

import 'package:attendance_system/components/constant/app_icon.dart';
import 'package:attendance_system/components/card_component.dart';
import 'package:attendance_system/components/constant/size.dart';
import 'package:attendance_system/components/text_component.dart';
import 'package:attendance_system/components/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'constant/app_theme.dart';

class DashboardInputComponent extends StatefulWidget {
  DashboardInputComponent(
      {Key? key,
      this.globalKey,
      this.title,
      this.inputValue,
      required this.onChanged,
      this.maxlines,
      this.hintText,
      this.textInputType,
      this.inputFormatters,
      required this.validationError,
      this.inputCaractersCount,
      this.limitCaracters,
      this.icon,
      this.titleColor,
      this.hintColor,
      this.backgroundColor,
      this.height,
      this.textEditingController,
      this.borderColor,
      this.borderSize,
      this.trailingIcon,
      this.iconColor,
      this.padding,
      this.autoFocus,
      this.textColor,
      this.iconsize,
      this.prefix})
      : super(key: key);

  final String? hintText, inputCaractersCount;
  final int? maxlines;
  String? inputValue, title, leadingText;
  final Function(String inputValue) onChanged;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final dynamic validationError;
  String? icon, prefix;

  int? limitCaracters;
  double? height, iconsize;
  TextEditingController? textEditingController;
  GlobalKey? globalKey;
  Color? borderColor;
  Widget? trailingIcon;
  double? borderSize;
  Color? titleColor,
      textColor,
      hintColor,
      backgroundColor,
      iconColor,
      leadingTextColor;
  EdgeInsets? padding;
  bool? autoFocus;

  @override
  State<DashboardInputComponent> createState() =>
      _DashboardInputComponentState();
}

class _DashboardInputComponentState extends State<DashboardInputComponent> {
  TextEditingController controller = TextEditingController();
  late AppTheme theme;

  @override
  void initState() {
    theme = context.read<AppTheme>();

    controller.text = widget.inputValue ?? "";
    if (widget.textEditingController != null) {
      widget.textEditingController!.text = widget.inputValue ?? "";
    }

    super.initState();
  }

  Widget _label() {
    return Text(widget.title.toString(),
        style: textStyle(12, FontWeight.w500,
            widget.titleColor ?? theme.getSecondaryFontColor));
  }

  Color _color() {
    return theme.currentTheme == theme.darkTheme
        ? Colors.transparent
        : Colors.black.withOpacity(0.1);
  }

  Widget _input() {
    return CardComponent(
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 14),
        borderColor: _inputBorderColor(),
        color: widget.backgroundColor ?? _color(),
        radius: 15,
        borderSize: widget.borderSize,
        child: Row(children: [
          if (widget.icon != null)
            Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: AppIcon(
                    icon: widget.icon!,
                    size: widget.iconsize ?? 16,
                    color: widget.iconColor ?? Colors.grey.shade300)),
          if (widget.leadingText != null)
            TextComponent(
                text: widget.leadingText!.toString(),
                // family: Fonts.fontRegular,
                size: 16,
                weight: FontWeight.w500,
                color: widget.leadingTextColor ?? theme.getSecondaryFontColor),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  constraints:
                      const BoxConstraints(maxHeight: 100, minHeight: 30),
                  child: TextFormField(
                    key: widget.key,
                    onEditingComplete: () {},
                    controller: widget.textEditingController ?? controller,
                    keyboardType: widget.textInputType ?? TextInputType.text,
                    onChanged: (value) => widget.onChanged(value),
                    inputFormatters: widget.limitCaracters != null
                        ? [
                            LengthLimitingTextInputFormatter(
                                widget.limitCaracters)
                          ]
                        : widget.inputFormatters,
                    maxLines: widget.maxlines,
                    style: TextStyle(
                        // fontFamily: Fonts.fontRegular,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        color: widget.textColor ?? theme.getPrimaryFontColor),
                    decoration: InputDecoration(
                        hintText: widget.title != null
                            ? widget.hintText ??
                                widget.title.toString().replaceAll(
                                    widget.title![0],
                                    widget.title![0].toUpperCase())
                            : widget.hintText,
                        border: InputBorder.none,
                        isDense: true,
                        hintStyle: TextStyle(
                            // fontFamily: Fonts.fontRegular,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: widget.hintColor ??
                                theme.getSecondaryFontColor)),
                    autofocus: widget.autoFocus ?? false,
                  ))),
          if (widget.trailingIcon != null)
            Container(
                margin: const EdgeInsets.only(left: 10),
                child: widget.trailingIcon)
        ]));
  }

  Widget _validationSection() {
    return Padding(
        padding: const EdgeInsets.only(top: 4),
        child: _validationErrorMessage());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(builder: (context, ap, _) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (widget.title != null)
          Padding(padding: const EdgeInsets.only(bottom: 5.0), child: _label()),
        _input(),
        heightSpace(2),
        _counterCaractersIndication(),
        if (widget.validationError != null) _validationSection()
      ]);
    });
  }

  dynamic _inputBorderColor() {
    if (widget.validationError != null) {
      return Colors.red;
    } else if (widget.borderColor != null) {
      return widget.borderColor;
    }
    return theme.border;
  }

  Widget _validationErrorMessage() {
    return widget.validationError != null
        ? Text(widget.validationError[0],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textStyle(14, FontWeight.normal, Colors.red))
        : const SizedBox();
  }

  Widget _counterCaractersIndication() {
    if (widget.limitCaracters != null) {
      return Text(
          "${(widget.inputValue ?? "").length}/${widget.limitCaracters} caractères restants",
          style: textStyle(14, FontWeight.w500, theme.getSecondaryFontColor));
    }

    return const SizedBox();
  }

  Color _prefixTextColor() {
    if (widget.textEditingController != null) {
      if (widget.textEditingController!.text.isEmpty) {
        return widget.hintColor ?? theme.getSecondaryFontColor;
      } else {
        return widget.textColor ?? theme.getPrimaryFontColor;
      }
    } else {
      if (controller.text.isEmpty) {
        return widget.hintColor ?? theme.getSecondaryFontColor;
      }
      return widget.textColor ?? theme.getPrimaryFontColor;
    }
  }
}
