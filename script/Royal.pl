/* Facts */
female(queenElizabethII).
female(diana).
female(camillaParkerBowles).
female(sarahFerguson).
female(kateMiddleton).
female(meghanMarkle).
female(princessEugenieofYork).
female(princessBeatriceofYork).
female(princessCharlotteofCambridge).
female(princessAnnePrincessRoyal).
female(sophieRhysJones).
female(autumnPhillips).
female(zaraTindall).
female(ladyLouiseWindsor).

male(princePhilip).
male(princeCharles).
male(princeAndrew).
male(princeWilliam).
male(princeHarry).
male(princeLouis).
male(archieHarrison).
male(marksPhillips).
male(timothyLaurence).
male(princeEdward).
male(peterPhillips).
male(mikeTindall).
male(princeGeorge).
male(james).

parent(queenElizabethII,princeCharles).
parent(queenElizabethII,princeAndrew).
parent(queenElizabethII,princessAnnePrincessRoyal).
parent(queenElizabethII,princeEdward).
parent(princePhilip,princeCharles).
parent(princePhilip,princeAndrew).
parent(princePhilip,princessAnnePrincessRoyal).
parent(princePhilip,princeEdward).
parent(diana,princeWilliam).
parent(diana,princeHarry).
parent(princeCharles,princeWilliam).
parent(princeCharles,princeHarry).
parent(princeAndrew,princessEugenieofYork).
parent(princeAndrew,princessBeatriceofYork).
parent(sarahFerguson,princessEugenieofYork).
parent(sarahFerguson,princessBeatriceofYork).
parent(kateMiddleton,princeGeorge).
parent(kateMiddleton,princessCharlotteofCambridge).
parent(kateMiddleton,princeLouis).
parent(princeWilliam,princeGeorge).
parent(princeWilliam,princessCharlotteofCambridge).
parent(princeWilliam,princeLouis).
parent(princeHarry,archieHarrison).
parent(meghanMarkle,archieHarrison).
parent(marksPhillips,peterPhillips).
parent(princessAnnePrincessRoyal,peterPhillips).
parent(marksPhillips,zaraTindall).
parent(princessAnnePrincessRoyal,zaraTindall).
parent(princeEdward,ladyLouiseWindsor).
parent(princeEdward,james).
parent(sophieRhysJones,ladyLouiseWindsor).
parent(sophieRhysJones,james).

married(princePhilip,queenElizabethII).
married(queenElizabethII,princePhilip).
married(princeAndrew,sarahFerguson).
married(sarahFerguson,princeAndrew).
married(princeWilliam,kateMiddleton).
married(kateMiddleton,princeWilliam).
married(princeHarry,meghanMarkle).
married(meghanMarkle,princeHarry).
married(princeEdward,sophieRhysJones).
married(sophieRhysJones,princeEdward).
married(peterPhillips,autumnPhillips).
married(autumnPhillips,peterPhillips).
married(mikeTindall,zaraTindall).
married(zaraTindall, mikeTindall).
married(timothyLaurence,princessAnnePrincessRoyal).
married(princessAnnePrincessRoyal,timothyLaurence).
married(princeCharles,camillaParkerBowles).
married(camillaParkerBowles,princeCharles).
divorced(princeCharles,diana).
divorced(diana,princeCharles).
divorced(marksPhillips,princessAnnePrincessRoyal).
divorced(princessAnnePrincessRoyal,marksPhillips).
/* Rule */
husband(X,Y):- male(X),married(X,Y), X\=Y.
wife(X,Y):- female(X), married(X,Y), X\=Y.
father(X,Y) :- parent(X,Y), male(X), X\=Y.
mother(X,Y) :- parent(X,Y), female(X), X\=Y.
child(X,Y) :- (father(Y,X); mother(Y,X)), X\=Y.
son(X,Y) :- child(X,Y), male(X), X\=Y.
daughter(X,Y) :- child(X,Y), female(X), X\=Y.
grandparent(X,Y):- ((mother(X,P), mother(P,Y));(mother(X,P), father(P,Y));
(father(X,P), father(P,Y)); (father(X,P),mother(P,Y))), X\=Y.
grandfather(X,Y) :- ((father(X,M), father(M,Y)); (father(X,F), mother(F,Y))), X\=Y.
grandmother(X,Y):- (mother(X,M), mother(M,Y)); (mother(X,F),father(F,Y)), X\=Y.
grandchild(X,Y):- (child(X,P), mother(Y,P));(child(X,P), father(Y,P)),X\=Y.
grandson(X,Y) :- (son(X,P), father(Y,P));(son(X,P), mother(Y,P)),X\=Y.
granddaughter(X,Y) :- (daughter(X,P), father(Y,P));(daughter(X,P), mother(Y,P)),X\=Y.
sibling(X,Y) :- father(F,X), father(F,Y), mother(M,X), mother(M,Y), X\=Y.
brother(X,Y) :- male(X), sibling(X,Y),X\=Y.
sister(X,Y) :- female(X), sibling(X,Y),X\=Y.
uncle(X,Y) :- male(X), ((sibling(X,F), father(F,Y)); (sibling(X,M), mother(M,Y))), X\=Y.
aunt(X,Y) :- female(X), ((sibling(X,P), father(P,Y)); (sibling(X,P), mother(P,Y))), X\=Y.
niece(X,Y) :- daughter(X,P), sibling(P,Y),X\=Y.
nephew(X,Y) :- son(X,P), sibling(P,Y),X\=Y.


/*Chay tap du lieu Test*/

run_script:-  write('Cau 1: Ai la cha cua Archie Harrison?').
run_script:- (father(X,archieHarrison)), write(X). 
run_script:- (write('\nCau 2: Prince Charles co phai la ong cua Archie Harrison khong? '),grandfather(princeCharles,archieHarrison)).
run_script:- write('\nCau 3: Prince William va Prince Harry co phai la hai anh em khong?'),brother(princeWilliam,princeHarry).
run_script:- write('\nCau 4: Ai la me cua Prince Andrew?\n').
run_script:- mother(X,princeAndrew),write(X).
run_script:- write('\nCau 5:  Ai la chi gai cua Prince Edward?\n').
run_script:- sister(X, princeEdward),write(X).
run_script:- write('\nCau 6: Prince Harry co phai la bac cua James khong ? '), (uncle(princeHarry,james)).
run_script:- write('\nCau 7: Nu hoang Elizabeth co phai la vo cua Timothy Laurence khong? '),wife(queenElizabethII,timothyLaurence).
run_script:- write('\nCau 8: Ai la co cua Lady Louise Windsor?').
run_script:- aunt(X, ladyLouiseWindsor),write(X).
run_script:- write('\nCau 9: Mark Phillips co phai la cha cua Prince George khong?'), father(markPhillips, princeGeorge).
run_script:- write('\nCau 10: Peter Phillips co phai la chau trai (nephew) cua Prince Edward khong?'),nephew(peterPhillips,princeEdward).
run_script:- write('\nCau 11: Zara Tindall co phai la chau gai (niece) cua Meghan Markle khong?'),niece(zaraTindall,meghanMarkle).
run_script:- write('\nCau 12: Ai la bac cua Zara Tindall?').
run_script:- uncle(X, zaraTindall),write(X).
run_script:- write('\nCau 13: Prince Philip co phai la cha cua Prince Charles khong?'), father(princePhilip, princeCharles).
run_script:- write('\nCau 14:  Ai la anh/em trai cua Prince Edward?').
run_script:- brother(X,princeEdward),write(X).
run_script:- write('\nCau 15: Ai la vo cua Prince William?\n').
run_script:- wife(X,princeWilliam),write(X).
run_script:- write('\nCau 16: Prince Charles da ly hon voi Diana chua?'), divorced(princeCharles, diana).
run_script:- write('\nCau 17: Nu hoang Elizabeth co phai la ba cua Prince Harry khong?'),grandmother(queenElizabethII,princeHarry).
run_script:- write('\nCau 18: Princess Eugenie co phai la chau(grandchild) cua Prince Philip khong?'),grandchild(princessEugenieofYork, princePhilip).
run_script:- write(' \nCau 19: Ai la ong cua Princess Charlotte'),grandfather(X,princessCharlotteofCambridge),write(X).
run_script:- write(' \nCau 20: Prince Louis co phai la chau trai(grandson)cua Diana khong?'),grandson(princeLouis,diana).
run_script:- write('\nCau 21:  Ai la chau gai (granddaughter) cua nu hoang Elizabeth?').
run_script:- granddaughter(X,queenElizabethII),write(X).
run_script:- write('\nCau 22: Ai la vo hien tai cua Prince Charles?').
run_script:- wife(X,princeCharles),write(X).
run_script:- write('\nCau 23: Ai la chong cua Kate Middleton? ').
run_script:- husband(X, kateMiddleton), write(X).
run_script:- write('\nCau 24: Ai la chau cua Diana?').
run_script:- grandchild(X,diana),write(X).
run_script:- write('\nCau 25: Liet ke cac cap vo chong').
run_script:- husband(X,Y),write(X),write(','), write(Y).
run_script:- write('\nCau 26: Liet ke cac cap co chau').
run_script:- aunt(X,Y),write(X),write(','), write(Y).
run_script:- write('\nCau 27: Liet ke cac cap ong chau').
run_script:- grandfather(X,Y),write(X),write(','), write(Y).
























