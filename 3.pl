% Решение задачи о трёх учителях и шести предметах
% Учителя: Морозов, Васильев, Токарев
% Предметы: история(и), математика(м), биология(б), география(г), английский(а), французский(ф)

% Каждый учитель ведёт 2 предмета
% Все предметы распределены между тремя учителями

% Предикат для проверки, что все предметы распределены
all_subjects(S1, S2, S3) :-
    % Предметы каждого учителя - это список из 2 предметов
    % Объединяем все предметы
    append(S1, S2, Temp),
    append(Temp, S3, All),
    % Сортируем и проверяем, что это все 6 предметов
    sort(All, [и, м, б, г, а, ф]).

% Проверка, что предмет входит в список предметов учителя
teaches(Teacher, Subject, TeacherSubjects) :-
    member(Subject, TeacherSubjects).

% Основной предикат решения
solve(Teachers) :-
    % Перебираем все возможные пары предметов для Морозова
    % (все комбинации из 6 предметов по 2)
    morozov(M),
    % Для Васильева - из оставшихся предметов
    vasiliev(V),
    % Для Токарева - остальные
    tokarev(T),
    
    % Проверяем, что все предметы распределены
    all_subjects(M, V, T),
    
    % Формируем список учителей с их предметами
    Teachers = [морозов-M, васильев-V, токарев-T],
    
    % Применяем все условия задачи
    conditions(Teachers).

% Генерация всех возможных пар предметов
subject_pair(Pair) :-
    Subject = [и, м, б, г, а, ф],
    select(X, Subject, Rest),
    select(Y, Rest, _),
    sort([X, Y], Pair).

% Предметы Морозова
morozov(M) :- subject_pair(M).

% Предметы Васильева (из оставшихся, но пока просто генерируем)
vasiliev(V) :- subject_pair(V).

% Предметы Токарева (определятся автоматически при проверке all_subjects)
tokarev(T) :- subject_pair(T).

% Проверка всех условий
conditions(Teachers) :-
    % Извлекаем предметы каждого учителя
    member(морозов-M, Teachers),
    member(васильев-V, Teachers),
    member(токарев-T, Teachers),
    
    % Условие 1: Географ и учитель французского – соседи по дому
    % (разные люди, но есть связь, просто проверяем, что это разные учителя)
    geography_teacher(Teachers, GeoTeacher),
    french_teacher(Teachers, FrenchTeacher),
    GeoTeacher \= FrenchTeacher,
    
    % Условие 2: Учитель биологии старше учителя математики
    % Морозов – самый молодой
    biology_teacher(Teachers, BioTeacher),
    math_teacher(Teachers, MathTeacher),
    BioTeacher \= MathTeacher,
    BioTeacher \= морозов,     % Биолог не Морозов
    MathTeacher \= морозов,    % Математик не Морозов
    % Старше - в данном случае просто разные люди
    % (возраст не моделируем, только различие)
    
    % Условие 3: В понедельник первый урок у Токарева, у биолога и у учителя французского
    % Это три разных человека
    % Значит Токарев, биолог и учитель французского - три разных человека
    biology_teacher(Teachers, Bio),
    french_teacher(Teachers, French),
    токарев \= Bio,
    токарев \= French,
    Bio \= French,
    
    % Условие 4: В воскресенье Морозов, математик и учитель английского были на рыбалке
    % Три разных человека
    math_teacher(Teachers, Math),
    english_teacher(Teachers, English),
    морозов \= Math,
    морозов \= English,
    Math \= English.

% Вспомогательные предикаты для поиска учителя по предмету
geography_teacher(Teachers, Teacher) :-
    member(Teacher-Subjects, Teachers),
    member(г, Subjects).

french_teacher(Teachers, Teacher) :-
    member(Teacher-Subjects, Teachers),
    member(ф, Subjects).

biology_teacher(Teachers, Teacher) :-
    member(Teacher-Subjects, Teachers),
    member(б, Subjects).

math_teacher(Teachers, Teacher) :-
    member(Teacher-Subjects, Teachers),
    member(м, Subjects).

english_teacher(Teachers, Teacher) :-
    member(Teacher-Subjects, Teachers),
    member(а, Subjects).

history_teacher(Teachers, Teacher) :-
    member(Teacher-Subjects, Teachers),
    member(и, Subjects).

% Вывод результата
print_solution(Teachers) :-
    write('Результат:'), nl,
    member(морозов-M, Teachers),
    member(васильев-V, Teachers),
    member(токарев-T, Teachers),
    write('Морозов: '), write(M), nl,
    write('Васильев: '), write(V), nl,
    write('Токарев: '), write(T), nl.

% Основной предикат для запуска
run :-
    solve(Teachers),
    print_solution(Teachers).