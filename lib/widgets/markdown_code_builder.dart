import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'highlight_code_block.dart';

class MarkdownCodeBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(element, TextStyle? preferredStyle) {
    final language = element.attributes['class']
            ?.replaceFirst('language-', '') ??
        '';

    final code = element.textContent;

    return HighlightCodeBlock(
      code: code,
      language: language,
    );
  }
}
