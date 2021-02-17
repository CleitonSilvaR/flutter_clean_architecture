import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/modules/search/domain/errors/errors.dart';
import 'package:flutter_clean_architecture/modules/search/infra/datasources/search_datasource.dart';
import 'package:flutter_clean_architecture/modules/search/infra/models/result_search_model.dart';
import 'package:flutter_clean_architecture/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchDatasourceMock extends Mock implements SearchDataource {}

main() {
  final dataource = SearchDatasourceMock();
  final repository = SearchRepositoryImpl(dataource);

  test('deve retornar uma lista de ResultaSearch', () async {
    when(dataource.getSearch(any))
        .thenAnswer((_) async => <ResultSearchModel>[]);

    final result = await repository.search('teste');

    expect(result | null, isA<List<ResultSearchModel>>());
  });

  test('deve retornar um DatasourceError se o datasource falhar', () async {
    when(dataource.getSearch(any)).thenThrow(Exception());

    try {
      final result = await repository.search('teste');
      expect(result.fold(id, id), isA<DatasourceError>());
    } on DatasourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DatasourceError());
    }
  });
}
