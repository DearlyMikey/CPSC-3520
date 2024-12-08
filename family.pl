% facts
male(robert).
male(bob).
male(michael).
male(mark).
male(jake).
male(tom).
male(john).
male(peter).

female(linda).
female(alice).
female(sarah).
female(chloe).
female(emma).
female(nancy).
female(lisa).
female(amy).

% relationships
parent(robert,alice).
parent(linda,alice).
parent(robert,michael).
parent(linda,michael).
parent(robert,mark).
parent(linda,mark).
parent(alice,jake).
parent(bob,jake).
parent(alice,emma).
parent(bob,emma).
parent(michael,nancy).
parent(sarah,nancy).
parent(michael,tom).
parent(sarah,tom).
parent(mark,john).
parent(chloe,john).
parent(mark,lisa).
parent(chloe,lisa).
parent(nancy,peter).
parent(nancy,amy).

married(robert,linda).
married(alice,bob).
married(michael,sarah).
married(mark,chloe).

age(robert,68).
age(linda,65).
age(alice,42).
age(bob,44).
age(michael,41).
age(sarah,42).
age(mark,45).
age(chloe,43).
age(jake,15).
age(emma,12).
age(nancy,20).
age(tom,10).
age(john,20).
age(lisa,17).
age(peter,2).
age(amy,1).

% rules
sibling(X,Y):-
    parent(Z, X),
    parent(Z, Y),
    X \= Y.

grandparent(X,Y):- 
    parent(X,Z), 
    parent(Z,Y).

cousin(X,Y):-
    parent(P,X), 
    parent(S,Y), 
    once(sibling(P,S)),
    X \= Y.

mother(X,Y):- 
    parent(X,Y),
    female(X).

father(X,Y):- 
    parent(X,Y),
    male(X).

uncle(X,Y):- 
    parent(Z,Y), 
    sibling(X,Z), 
    male(X).

aunt(X,Y):- 
    parent(Z,Y), 
    sibling(X,Z), 
    female(X).

ancestor(A,C):- parent(A,C).
ancestor(A,C):- parent(A,D), ancestor(D,C).

older_sibling(O,Y):- 
    sibling(O,Y),
    age(O, A1),
    age(Y, A2),
    A1 > A2.

bigger_brother(B,S):-
    sibling(B,S),
    age(B, A1),
    age(S, A2),
    male(B),
    A1 > A2.

bigger_sister(B,S):-
    sibling(B,S),
    age(B,A1),
    age(S,A2),
    female(B),
    A1 > A2.

brother_in_law(X,Y):-
    sibling(X,Z),
    married(Z,Y),
    male(X).
brother_in_law(X,Y):-
    married(Z,Y),
    sibling(X,Z),
    male(X).

sister_in_law(X,Y):-
    sibling(X,Z),
    married(Z,Y),
    female(X).
sister_in_law(X,Y):-
    sibling(Z,Y),
    married(X,Z),
    female(X).

nth_ancestor(1,Ancestor,Person):-
    parent(Ancestor,Person).

nth_ancestor(N, Ancestor, Person):-
    N > 1,
    parent(Parent,Person),
    N1 is N - 1,
    nth_ancestor(N1,Ancestor,Parent).

common_ancestor(P1,P2,Ancestor):-
    ancestor(Ancestor, P1),
    ancestor(Ancestor, P2).

common_ancestors(Person1, Person2, AncestorList):-
    findall(Ancestor, (ancestor(Ancestor, Person1), ancestor(Ancestor, Person2)), AncestorList).