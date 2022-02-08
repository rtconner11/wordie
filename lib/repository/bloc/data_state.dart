class DataState {
  final bool isLoading;
  final bool loadSucceeded;

  const DataState({
    required this.isLoading,
    required this.loadSucceeded,
  });

  DataState copyWith({
    bool? isLoading,
    bool? loadSucceeded,
  }) =>
      DataState(
        isLoading: isLoading ?? this.isLoading,
        loadSucceeded: loadSucceeded ?? this.loadSucceeded,
      );
}
