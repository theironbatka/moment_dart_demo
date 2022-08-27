import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart_demo/components/header.dart';
import 'package:moment_dart_demo/components/section.dart';
import 'package:moment_dart_demo/components/snippet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Timer timer;
  int secondsElapsed = -1;

  String activeLocale = "en_US";

  final Map<String, MomentLocalization> locales =
      MomentLocalizations.locales.map((key, value) => MapEntry(key, value()));

  void updateLocale(String code) {
    setState(() {
      activeLocale = code;
    });
  }

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      secondsElapsed++;
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo for moment_dart 0.10.1"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: _build(context),
        ),
      ),
    );
  }

  Widget _build(context) {
    const Widget divider = SizedBox(height: 12.0);

    final MomentLocalization activeLocalization =
        MomentLocalizations.byLocale(activeLocale)!;

    final Moment now = Moment.now(localization: activeLocalization);

    final List<SnippetEntry?> formats = [
      SnippetEntry(
        "final localization = MomentLocalizations.byLocale(\"$activeLocale\")!;",
        now.localization.endonym,
      ),
      SnippetEntry(
        "final now = Moment.now(localization: localization);",
        "$now",
      ),
      null,
      SnippetEntry(
        r'now.format();',
        now.format(),
      ),
      SnippetEntry(
        r'now.format("YYYY MMMM Do - hh:mm:ssa");',
        now.format("YYYY MMMM Do - hh:mm:ssa"),
      ),
      SnippetEntry(
        r'now.format("LTS");',
        now.format("LTS"),
      ),
      SnippetEntry(
        r'now.format("dddd");',
        now.format("dddd"),
      ),
      SnippetEntry(
        r'now.format("MMM Do YY");',
        now.format("MMM Do YY"),
      ),
    ];

    final List<SnippetEntry?> relatives = [
      SnippetEntry(
        r"Moment(DateTime(2003,6,1)).fromNow();",
        Moment(DateTime(2003, 6, 1), localization: activeLocalization)
            .fromNow(),
      ),
      SnippetEntry(
        r"Moment(DateTime(2012,12,21)).fromNow();",
        Moment(DateTime(2012, 12, 21), localization: activeLocalization)
            .fromNow(),
      ),
      SnippetEntry(
        r"Moment.now().lastMonday().fromNow(form: UnitStringForm.short);",
        Moment.now(localization: activeLocalization)
            .lastMonday()
            .fromNow(form: UnitStringForm.short),
      ),
      null,
      SnippetEntry(
        r"Moment.now().subtract(const Duration(minutes: 2, seconds: 47)).fromNow();",
        Moment.now(localization: activeLocalization)
            .subtract(const Duration(minutes: 2, seconds: 47))
            .fromNowPrecise(),
      ),
      SnippetEntry(
        r"Moment.now().add(const Duration(days: 23)).fromNowPrecise(includeWeeks: true, form: UnitStringForm.mid);",
        Moment.now(localization: activeLocalization)
            .add(const Duration(days: 23))
            .fromNowPrecise(includeWeeks: true, form: UnitStringForm.mid),
      ),
    ];

    final List<SnippetEntry?> calendar = [
      SnippetEntry(
        r"Moment.now().subtract(const Duration(days: 10)).calendar();",
        Moment.now(localization: activeLocalization)
            .subtract(const Duration(days: 10))
            .calendar(),
      ),
      SnippetEntry(
        r"Moment.now().subtract(const Duration(days: 6)).calendar();",
        Moment.now(localization: activeLocalization)
            .subtract(const Duration(days: 6))
            .calendar(),
      ),
      SnippetEntry(
        r"Moment.now().subtract(const Duration(days: 3)).calendar();",
        Moment.now(localization: activeLocalization)
            .subtract(const Duration(days: 3))
            .calendar(),
      ),
      SnippetEntry(
        r"Moment.now().subtract(const Duration(days: 1)).calendar();",
        Moment.now(localization: activeLocalization)
            .subtract(const Duration(days: 1))
            .calendar(),
      ),
      SnippetEntry(
        r"Moment.now().calendar();",
        Moment.now(localization: activeLocalization).calendar(),
      ),
      SnippetEntry(
        r"Moment.now().add(const Duration(days: 1)).calendar();",
        Moment.now(localization: activeLocalization)
            .add(const Duration(days: 1))
            .calendar(),
      ),
      SnippetEntry(
        r"Moment.now().add(const Duration(days: 3)).calendar();",
        Moment.now(localization: activeLocalization)
            .add(const Duration(days: 3))
            .calendar(),
      ),
      SnippetEntry(
        r"Moment.now().add(const Duration(days: 10)).calendar();",
        Moment.now(localization: activeLocalization)
            .add(const Duration(days: 10))
            .calendar(),
      ),
    ];

    final List<String> sorted = [...locales.keys]..sort();

    return Column(
      children: [
        const SizedBox(height: 16.0),
        Text(
          "Total of ${locales.length} localizations, sorted by language code",
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontFamily: 'Cascadia Code',
              ),
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: sorted.map((e) {
            return ChoiceChip(
              avatar: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Center(
                  child: Text(
                    locales[e]!.languageCode,
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
              label: Text(locales[e]!.languageNameInEnglish),
              selected: e == activeLocale,
              onSelected: (selected) => selected ? updateLocale(e) : null,
            );
          }).toList(),
        ),

        const SizedBox(height: 16.0),
        // Formats
        const Header(text: "Formats"),
        Section(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final entry in formats)
                entry == null ? divider : Snippet(entry: entry),
            ],
          ),
        ),
        const SizedBox(height: 16.0),

        // Relative Time

        const Header(text: "Relative Time"),
        Section(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final entry in relatives)
                entry == null ? divider : Snippet(entry: entry),
            ],
          ),
        ),
        const SizedBox(height: 16.0),

        // Calendar

        const Header(text: "Calendar"),
        Section(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final entry in calendar)
                entry == null ? divider : Snippet(entry: entry),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
