typedef Mapper<F, T> = T Function(F from);
typedef ListMapper<F, T> = List<T> Function(List<F> from);


ListMapper<F, T> toListMapper<F, T>(Mapper<F, T> mapper) =>
    (List<F> list) => list.map(mapper).toList(growable: false);
