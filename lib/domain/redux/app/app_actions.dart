class InitialAction {
  const InitialAction();
}

class ShowMessageAction {
  final String message;
  final MessageSubAction? subAction;

  ShowMessageAction({
    required this.message,
    this.subAction,
  });
}

class MessageSubAction {
  final String label;
  final dynamic action;

  MessageSubAction({required this.label, required this.action});
}


