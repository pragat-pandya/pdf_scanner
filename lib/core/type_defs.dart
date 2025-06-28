import 'package:fpdart/fpdart.dart';
import 'package:pdf_scanner/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
