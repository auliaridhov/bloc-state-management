import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloctutorial/blocs/user/user_bloc.dart';
import 'package:bloctutorial/blocs/user/user_event.dart';
import 'package:bloctutorial/blocs/user/user_state.dart';
import 'package:bloctutorial/models/user_model.dart';

import 'mocks/mocks.mocks.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('UserBloc', () {
    late MockUserRepository mockUserRepository;
    late UserBloc userBloc;

    final fakeUsers = [
      User(id: 1, name: 'Ridho', email: 'ridho@example.com'),
      User(id: 2, name: 'Dewi', email: 'dewi@example.com'),
    ];

    setUp(() {
      mockUserRepository = MockUserRepository();
      userBloc = UserBloc(mockUserRepository);
    });

    tearDown(() {
      userBloc.close();
    });

    test('initial state is UserInitial', () {
      expect(userBloc.state, UserInitial());
    });

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserLoaded] when LoadUsers is added',
      build: () {
        when(mockUserRepository.fetchUsers())
            .thenAnswer((_) async => fakeUsers);
        return userBloc;
      },
      act: (bloc) => bloc.add(LoadUsers()),
      expect: () => [
        UserLoading(),
        UserLoaded(fakeUsers),
      ],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserError] when repository throws',
      build: () {
        when(mockUserRepository.fetchUsers()).thenThrow(Exception('Failed'));
        return userBloc;
      },
      act: (bloc) => bloc.add(LoadUsers()),
      expect: () => [
        UserLoading(),
        isA<UserError>(),
      ],
    );
  });
}
