import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class ColorSelector extends StatefulWidget {
  final Color color;
  final Function onChange;
  const ColorSelector(this.color, this.onChange, {Key? key}) : super(key: key);

  @override
  _ColorSelectorState createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  late Color color;
  @override
  void initState() {
    this.color = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColorIndicator(
                      borderRadius: 0,
                      color: color,
                      elevation: 1,
                      onSelectFocus: false,
                      onSelect: () async {
                        // Wait for the dialog to return color selection result.
                        final Color newColor = await showColorPickerDialog(
                          // The dialog needs a context, we pass it in.
                          context,
                          // We use the dialogSelectColor, as its starting color.
                          color,
                          title: Text('ColorPicker',
                              style: Theme.of(context).textTheme.headline6),
                          spacing: 0,
                          runSpacing: 0,
                          borderRadius: 0,
                          wheelDiameter: 165,
                          enableOpacity: false,
                          showColorCode: true,
                          colorCodeHasColor: true,
                          pickersEnabled: <ColorPickerType, bool>{
                            ColorPickerType.primary: true,
                            ColorPickerType.wheel: true
                          },
                          copyPasteBehavior: const ColorPickerCopyPasteBehavior(
                            copyButton: true,
                            pasteButton: true,
                            longPressMenu: true,
                          ),
                          actionButtons: const ColorPickerActionButtons(
                            okButton: true,
                            closeButton: true,
                            dialogActionButtons: true,
                          ),
                          constraints: const BoxConstraints(
                              minHeight: 480, minWidth: 320, maxWidth: 320),
                        );
                        setState(() {
                          color = newColor;
                          widget.onChange(color);
                        });
                      });
  }
}