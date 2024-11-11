import 'dart:async';

Timer? _debounceTimer;

void timerCommonFunction(String val, Function() onComplete) {
  // widget.overrideMrpPriceController.clear();

  if (_debounceTimer != null && _debounceTimer!.isActive) {
    _debounceTimer!.cancel();
  }
  _debounceTimer = Timer(const Duration(milliseconds: 500), () {
    if (val.isEmpty) {
      onComplete();
    } else {
      // widget.overrideBasePriceOnChanged?.call(amount, 'N');
      onComplete();
    }
  });
}
