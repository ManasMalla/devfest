import 'package:flutter/material.dart';

class RadioForm<T> extends StatefulWidget {
  final String label;
  final IconData? icon;
  final T data;
  final void Function(T) onSelected;
  final List<T> options;
  const RadioForm(
      {Key? key,
      required this.label,
      this.icon,
      required this.data,
      required this.onSelected,
      required this.options})
      : super(key: key);

  @override
  State<RadioForm<T>> createState() => _RadioFormState<T>();
}

class _RadioFormState<T> extends State<RadioForm<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Icon(
              widget.icon,
              size: Theme.of(context).textTheme.titleMedium?.fontSize,
              color: Colors.black45,
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              widget.label,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return RadioListTile<T>(
                  title: Text(widget.options[index].toString()),
                  value: widget.options[index],
                  groupValue: widget.data,
                  onChanged: (_) {
                    widget.onSelected(_ ?? widget.options[index]);
                  });
            },
            itemCount: widget.options.length)
      ],
    );
  }
}
