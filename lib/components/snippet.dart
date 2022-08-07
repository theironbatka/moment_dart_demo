import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';

class SnippetEntry {
  final String text;
  final String description;

  const SnippetEntry(this.text, this.description);
}

class Snippet extends StatelessWidget {
  final SnippetEntry entry;

  final Map<String, TextStyle> theme = {
    ...githubTheme,
    'root': const TextStyle(
      color: Color(0xff333333),
      backgroundColor: Color(0xfff8f8f8),
    ),
  };

  Snippet({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: HighlightView(
            entry.text,
            language: "dart",
            theme: theme,
            textStyle: const TextStyle(fontFamily: 'Cascadia Code'),
          ),
          // Text(entry.text, style: Theme.of(context).textTheme.bodyText2),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            "// ${entry.description}",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: const Color(0x99000000)),
          ),
        ),
      ],
    );
  }
}
