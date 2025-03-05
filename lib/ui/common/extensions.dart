import 'package:flutter/material.dart';

extension StyledText on Text {
  Text withFontSize(double size) {
    return Text(
      data ?? '',
      style: style?.copyWith(fontSize: size) ?? TextStyle(fontSize: size),
    );
  }

  Text withColor(Color color) {
    return Text(
      data ?? '',
      style: style?.copyWith(color: color) ?? TextStyle(color: color),
    );
  }

  Text withFontWeight(FontWeight fontWeight) {
    return Text(
      data ?? '',
      style: style?.copyWith(fontWeight: fontWeight) ??
          TextStyle(fontWeight: fontWeight),
    );
  }
}

extension StyledContainer on Container {
  Container withPadding(EdgeInsets padding) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: decoration,
      child: child,
    );
  }

  Container withMargin(EdgeInsets margin) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: decoration,
      child: child,
    );
  }

  Container withDecoration(BoxDecoration decoration) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: decoration,
      child: child,
    );
  }
}

extension StyledBoxDecoration on BoxDecoration {
  BoxDecoration withBorderRadius(int borderRadius) {
    return copyWith(
        borderRadius: BorderRadius.circular(borderRadius.toDouble()));
  }

  BoxDecoration withColor(Color color) {
    return copyWith(color: color);
  }

  BoxDecoration withBorder(Border border) {
    return copyWith(border: border);
  }
}
