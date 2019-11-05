implement main
    open core

class predicates
    func : (real X, integer N) -> real nondeterm.
    func : (real X, integer N, integer, real) -> real nondeterm.
    readInteger : (string) -> integer determ.
    readReal : (string) -> real determ.
    pow : (integer X, integer N) -> real nondeterm.
    myfun : (integer X, integer N) -> real nondeterm.
    myfunmult : (integer X, integer N) -> real nondeterm. %из-за целого значения округляются, поэтому отличается

clauses
    readInteger(Message) = Integer :-
        console::write(Message),
        Str = console::readLine(),
        console::clearInput(),
        Integer = tryToTerm(integer, Str),
        console::nl.
    readReal(Message) = Real :-
        console::write(Message),
        Str = console::readLine(),
        console::clearInput(),
        Real = tryToTerm(real, Str),
        console::nl.
    func(X, N) = func(X, 0, N, 1).
    func(_, N, N, Res) = Res :-
        !.
    func(X, I, N, Res) = R :-
        NewI = I + 1,
        NewRes = (X - 2 * NewI) * Res / (X - (2 * NewI - 1)),
        R = func(X, NewI, N, NewRes).
    pow(P, 0) = 1 :-
        !.
    pow(P, N) = P * pow(P, N - 1).
    myfun(M, 0) = M :-
        !.
    myfun(M, 1) = M :-
        !.
    myfun(M, N) = myfun(M, N - 2) + myfun(M, N - 1) / pow(2, N - 1).
    myfunmult(M, 0) = M :-
        !.
    myfunmult(M, 1) = M * M :-
        !.
    myfunmult(M, N) = myfun(M, N) * myfunmult(M, N - 1).
    run() :-
        console::init(),
        std::repeat(),
        console::clearOutput(),
        N = readInteger("Input N, N>0 "),
        N > 0,
        X =
            /*readReal*/
            readInteger("Input X, X>0 "),
        X > 0, %= 2 * N + 1,
        H = myfunmult(X, N),
        stdio::write("Answer is ", H),
        C = stdio::readChar(),
        C <> '\n',
        !.
    run() :-
        _ = stdio::readChar().

end implement main

goal
    mainExe::run(main::run).
