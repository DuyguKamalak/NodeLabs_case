import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_radius.dart';

/// BuildContext bottom sheet extensions
extension BottomSheetExtension on BuildContext {
  /// Modal bottom sheet gösterir
  Future<T?> showBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = true,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor ?? AppColors.surfaceDark,
      elevation: elevation ?? 0,
      shape: shape ??
          const RoundedRectangleBorder(
            borderRadius: AppRadius.bottomSheet,
          ),
      clipBehavior: clipBehavior ?? Clip.antiAlias,
      builder: (context) => child,
    );
  }

  /// Özelleştirilmiş bottom sheet gösterir
  Future<T?> showCustomBottomSheet<T>({
    required Widget child,
    double? maxHeight,
    double? minHeight,
    Color? backgroundColor,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showBottomSheet<T>(
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      child: Container(
        constraints: BoxConstraints(
          minHeight: minHeight ?? 200,
          maxHeight: maxHeight ?? MediaQuery.of(this).size.height * 0.9,
        ),
        child: child,
      ),
    );
  }

  /// Liste seçim bottom sheet gösterir
  Future<T?> showSelectionBottomSheet<T>({
    required String title,
    required List<T> items,
    required String Function(T) itemLabel,
    Widget Function(T)? itemBuilder,
    T? selectedItem,
    bool showSearchBar = false,
  }) {
    return showBottomSheet<T>(
      child: _SelectionBottomSheet<T>(
        title: title,
        items: items,
        itemLabel: itemLabel,
        itemBuilder: itemBuilder,
        selectedItem: selectedItem,
        showSearchBar: showSearchBar,
      ),
    );
  }

  /// Onay bottom sheet gösterir
  Future<bool?> showConfirmationBottomSheet({
    required String title,
    required String message,
    String confirmText = 'Onayla',
    String cancelText = 'İptal',
    Color? confirmColor,
    bool isDanger = false,
  }) {
    return showBottomSheet<bool>(
      child: _ConfirmationBottomSheet(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        confirmColor:
            confirmColor ?? (isDanger ? AppColors.error : AppColors.primary),
      ),
    );
  }
}

class _SelectionBottomSheet<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final String Function(T) itemLabel;
  final Widget Function(T)? itemBuilder;
  final T? selectedItem;
  final bool showSearchBar;

  const _SelectionBottomSheet({
    required this.title,
    required this.items,
    required this.itemLabel,
    this.itemBuilder,
    this.selectedItem,
    this.showSearchBar = false,
  });

  @override
  State<_SelectionBottomSheet<T>> createState() =>
      _SelectionBottomSheetState<T>();
}

class _SelectionBottomSheetState<T> extends State<_SelectionBottomSheet<T>> {
  late List<T> filteredItems;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
    searchController.addListener(_filterItems);
  }

  void _filterItems() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = widget.items
          .where((item) => widget.itemLabel(item).toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Handle
        Container(
          width: 40,
          height: 4,
          margin: const EdgeInsets.only(top: 12, bottom: 20),
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(2),
          ),
        ),

        // Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),

        const SizedBox(height: 16),

        // Search bar
        if (widget.showSearchBar) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Ara...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Items
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              final item = filteredItems[index];
              final isSelected = item == widget.selectedItem;

              return ListTile(
                title: widget.itemBuilder?.call(item) ??
                    Text(widget.itemLabel(item)),
                selected: isSelected,
                onTap: () => Navigator.of(context).pop(item),
              );
            },
          ),
        ),

        SizedBox(height: MediaQuery.of(context).padding.bottom),
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

class _ConfirmationBottomSheet extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final Color confirmColor;

  const _ConfirmationBottomSheet({
    required this.title,
    required this.message,
    required this.confirmText,
    required this.cancelText,
    required this.confirmColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // Message
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),

          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(cancelText),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: confirmColor,
                  ),
                  child: Text(confirmText),
                ),
              ),
            ],
          ),

          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
