sealed class StorageState with _StoragePatternMatching {
  const StorageState._();

  const factory StorageState.error({
    required String message,
  }) = StorageErrorState;

  const factory StorageState.loading({
    required double progress,
  }) = StorageLoadingState;

  const factory StorageState.success({
    required String link,
  }) = StorageSuccessState;
}

final class StorageErrorState extends StorageState {
  const StorageErrorState({required this.message}) : super._();

  final String message;

  @override
  T map<T>({
    required T Function(StorageErrorState state) error,
    required T Function(StorageLoadingState state) loading,
    required T Function(StorageSuccessState state) success,
  }) =>
      error(this);
}

final class StorageLoadingState extends StorageState {
  const StorageLoadingState({required this.progress}) : super._();

  final double progress;

  @override
  T map<T>({
    required T Function(StorageErrorState state) error,
    required T Function(StorageLoadingState state) loading,
    required T Function(StorageSuccessState state) success,
  }) =>
      loading(this);
}

final class StorageSuccessState extends StorageState {
  const StorageSuccessState({required this.link}) : super._();

  final String link;

  @override
  T map<T>({
    required T Function(StorageErrorState state) error,
    required T Function(StorageLoadingState state) loading,
    required T Function(StorageSuccessState state) success,
  }) =>
      success(this);
}

mixin _StoragePatternMatching {
  T map<T>({
    required T Function(StorageErrorState state) error,
    required T Function(StorageLoadingState state) loading,
    required T Function(StorageSuccessState state) success,
  });
}
