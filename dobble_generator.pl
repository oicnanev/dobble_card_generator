:- use_module(library(clpfd)). % Include the CLP(FD) library

% Define symbols (Cyrillic alphabet + numbers)
symbols([
    "А", "Б", "В", "Г", "Д", "Е", "Ё", "Ж", "З", "И", "Й", "К", "Л", "М", "Н",
    "О", "П", "Р", "С", "Т", "У", "Ф", "Х", "Ц", "Ч", "Ш", "Щ", "Ъ", "Ы", "Ь",
    "Э", "Ю", "Я", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
]).

% Generate Dobble cards using finite projective planes of order Q
generate_dobble_cards(Q, Cards) :-
    P is Q + 1,
    TotalCards is P * P + P + 1,
    findall(Card, (
        between(0, Q, I),
        findall(S, (between(0, Q, J), symbol(Q, I, J, S)), Card)
    ), InitialCards),
    findall(Card, (
        between(0, Q, J),
        findall(S, (between(0, Q, I), extra_symbol(Q, I, J, S)), Card)
    ), ExtraCards),
    append(InitialCards, ExtraCards, AllCards),
    % Generate the final card with all symbols
    final_card(Q, FinalCard),
    append(AllCards, [FinalCard], CardsList),
    % Ensure only unique cards are kept
    sort(CardsList, Cards).

% Symbol generation using the primary card approach
symbol(Q, I, J, S) :-
    Index #= (I * Q + J) mod (Q * Q + Q + 1) + 1,
    symbols(Symbols),
    nth1(Index, Symbols, S).

% Symbol generation using the secondary card approach
extra_symbol(Q, I, J, S) :-
    Index #= (J * Q + I) mod (Q * Q + Q + 1) + 1,
    symbols(Symbols),
    nth1(Index, Symbols, S).

% Generate the final card with all symbols
final_card(Q, Card) :-
    N is Q + 1,
    length(Card, N),
    between(1, N, X),
    Card ins 1..N,
    symbols(Symbols),
    nth1(X, Symbols, _).

% Entry point to generate cards with given order Q
generate(Q) :-
    generate_dobble_cards(Q, Cards),
    writeln(Cards).

% Example usage: generate Dobble cards with order 6 (7 symbols per card)
:- generate(6).
