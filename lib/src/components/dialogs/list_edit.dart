import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:pui/src/components/variable_editor/variable_editor.dart';

class ListEditDialog<T> extends StatefulWidget {
  const ListEditDialog({
    this.defaultValue,
    this.defaultItemValue,
    this.maxLength = 9999,
    this.title,
    super.key,
  });
  final Iterable<T>? defaultValue;
  final T? defaultItemValue;
  final int? maxLength;
  final String? title;

  @override
  createState() => _ListEditDialogState<T>();
}

class _ListEditDialogState<T> extends State<ListEditDialog> {
  late final TextEditingController _controller;

  late IList<T> value;

  @override
  void initState() {
    super.initState();

    if (widget.defaultValue is IList<T>) {
      value = widget.defaultValue as IList<T>;
    } else {
      value = widget.defaultValue == null
          ? IList<T>()
          : IList<T>(widget.defaultValue as Iterable<T>);
    }

    _controller = TextEditingController(text: value.length.toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (value.length != int.tryParse(_controller.text)) {
      _controller.text = value.length.toString();
    }

    return AlertDialog(
      icon: const Icon(
        Symbols.lists,
        weight: 200,
      ),
      title: Text(widget.title ?? 'Edit List'),
      scrollable: true,
      content: Container(
        constraints: const BoxConstraints(
          minWidth: 350,
          minHeight: 100,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                FilledButton.tonalIcon(
                  onPressed: () {
                    setState(() {
                      value = value.add(widget.defaultItemValue as T);
                    });
                  },
                  icon: const Icon(Symbols.add),
                  label: const Text('Add'),
                ),
                const Spacer(),
                Flexible(
                  child: TextField(
                    controller: _controller,
                    expands: false,
                    onChanged: (text) {
                      var length = int.tryParse(text) ?? 0;
                      if (length < 0) return;
                      if (widget.maxLength != null) {
                        if (length > widget.maxLength!) {
                          length = widget.maxLength!;
                          _controller.text = length.toString();
                        }
                      }
                      if (length > value.length) {
                        // add values
                        value = value.addAll(
                          List<T>.generate(
                            length - value.length,
                            (index) => widget.defaultItemValue as T,
                          ).toIList(),
                        );
                      } else if (length < value.length) {
                        value = value.take(length).toIList();
                      }

                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      labelText: 'Length',
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(
                height: 1,
              ),
            ),
            if (value.isEmpty) noItems(),
            if (value.isNotEmpty)
              Flexible(
                child: builtList(),
              )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop(value);
          },
          style: Theme.of(context).filledButtonTheme.style?.copyWith(
                minimumSize: MaterialStateProperty.all(
                  const Size(20, 40),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 14),
                ),
              ),
          child: const Text('Submit'),
        ),
      ],
    );
  }

  Widget noItems() {
    return SizedBox(
      height: 300,
      width: 400,
      child: Center(
        child: Text(
          'No items',
          style: TextStyle(
            fontFamily: 'packages/pui/Albert Sans',
            fontSize: 26,
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.125),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget builtList() {
    return SizedBox(
      height: 300,
      width: 400,
      child: ReorderableListView.builder(
        buildDefaultDragHandles: false,
        itemCount: value.length,
        proxyDecorator: (child, index, animation) {
          return Material(
            color: Colors.transparent,
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                child,
                buildItem(index, value.elementAt(index), proxy: true)
                    .animate()
                    .fadeIn(duration: 250.ms, curve: Curves.easeOutCubic),
              ],
            ),
          );
        },
        itemBuilder: (context, i) {
          final item = value.elementAt(i);

          return buildItem(i, item);
        },
        onReorder: (oldIndex, newIndex) {
          final targetItem = value.elementAt(oldIndex);
          setState(() {
            if (oldIndex < newIndex) {
              // If moving down within the list
              value = value.removeAt(oldIndex);
              value = value.insert(newIndex - 1, targetItem);
            } else {
              // If moving up within the list
              value = value.removeAt(oldIndex);
              value = value.insert(newIndex, targetItem);
            }
          });
        },
      ),
    );
  }

  Widget buildItem(int index, T item, {bool proxy = false}) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      key: ValueKey(index),
      decoration: BoxDecoration(
        color: proxy ? colorScheme.secondaryContainer : colorScheme.surface,
        border: Border.all(
          color: colorScheme.secondary.withOpacity(0.25),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.only(bottom: 2),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            SizedBox.square(
              dimension: 32,
              child: ReorderableDragStartListener(
                index: index,
                child: Icon(
                  Symbols.drag_indicator,
                  weight: 300,
                  color: colorScheme.secondary.withOpacity(0.8),
                ),
              ),
            ),
            const Gap(8),
            Expanded(
              child: VariableEditor(
                value: item,
                onChanged: (dynamic value) {
                  setState(
                    () {
                      this.value = this.value.replace(index, value as T);
                    },
                  );
                },
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  value = value.removeAt(index);
                });
              },
              icon: Icon(
                Symbols.delete,
                size: 22,
                grade: 0,
                weight: 300,
                opticalSize: 24,
                fill: 0,
                color: colorScheme.error,
              ),
            ),
            const Gap(2),
          ],
        ),
      ),
    );
  }
}
