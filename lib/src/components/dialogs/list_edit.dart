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

  late IList<T> _value;
  int _reorderIncrement = 0;

  static const int _reorderMultiplier = 1000000;

  @override
  void initState() {
    super.initState();

    if (widget.defaultValue is IList<T>) {
      _value = widget.defaultValue as IList<T>;
    } else {
      _value = widget.defaultValue == null
          ? IList<T>()
          : IList<T>(widget.defaultValue as Iterable<T>);
    }

    _controller = TextEditingController(text: _value.length.toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_value.length != int.tryParse(_controller.text)) {
      _controller.text = _value.length.toString();
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
                      _value = _value.add(widget.defaultItemValue as T);
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
                      if (length > _value.length) {
                        // add values
                        _value = _value.addAll(
                          List<T>.generate(
                            length - _value.length,
                            (index) => widget.defaultItemValue as T,
                          ).toIList(),
                        );
                      } else if (length < _value.length) {
                        _value = _value.take(length).toIList();
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
            if (_value.isEmpty) noItems(),
            if (_value.isNotEmpty)
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
            Navigator.of(context).pop(_value);
          },
          style: Theme.of(context).filledButtonTheme.style?.copyWith(
                minimumSize: WidgetStateProperty.all(
                  const Size(20, 40),
                ),
                padding: WidgetStateProperty.all(
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
        itemCount: _value.length,
        proxyDecorator: (child, index, animation) {
          return Material(
            color: Colors.transparent,
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                child,
                buildItem(index, _value.elementAt(index), proxy: true)
                    .animate()
                    .fadeIn(duration: 250.ms, curve: Curves.easeOutCubic),
              ],
            ),
          );
        },
        itemBuilder: (context, i) {
          final item = _value.elementAt(i);

          return buildItem(i, item);
        },
        onReorder: (oldIndex, newIndex) {
          final targetItem = _value.elementAt(oldIndex);
          setState(() {
            if (oldIndex < newIndex) {
              // If moving down within the list
              _value = _value.removeAt(oldIndex);
              _value = _value.insert(newIndex - 1, targetItem);
            } else {
              // If moving up within the list
              _value = _value.removeAt(oldIndex);
              _value = _value.insert(newIndex, targetItem);
            }

            _reorderIncrement++;
          });
        },
      ),
    );
  }

  Widget buildItem(int index, T item, {bool proxy = false}) {
    final colorScheme = Theme.of(context).colorScheme;

    final uniqueKey = index + _reorderIncrement * _reorderMultiplier;

    return Container(
      key: ValueKey(uniqueKey),
      decoration: BoxDecoration(
        color: proxy ? colorScheme.secondaryContainer : colorScheme.surface,
        border: Border.all(
          color: colorScheme.secondary.withAlpha(60),
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
                  color: colorScheme.secondary.withAlpha(200),
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
                      this._value = this._value.replace(index, value as T);
                    },
                  );
                },
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _value = _value.removeAt(index);
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
