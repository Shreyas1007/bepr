%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


notice:-
write('This is an Example of an Expert System for finding Indian bird'),nl,
nl,
write('To use it, just answer the quizes the systems asks you.'),nl,
nl.


%hypothesises

bird(Name,peacock):-
                                                charis(Name, blue_color),
						charis(Name, national_bird).


bird(Name,sarus_crane):-
						charis(Name, resident_india),
						charis(Name, found_godavri_river),
						charis(Name, height_5_9ft),
						charis(Name, world_tallest).

bird(Name,rose_ring_parrot):-
						charis(Name, ring_neck),
						charis(Name, eat_fruit).

bird(Name,koel):-
						charis(Name, black_color),
						charis(Name, singing_bird),
                                                charis(Name, red_color_eye).

bird(Name,kingfisher):-
						charis(Name,found_near_river),
						charis(Name,eat_fish).

bird(Name,sparrow):-
						charis(Name, grey_color),
						charis(Name, do_dust_bathing),
						charis(Name, found_near_colonies).


/*Ask rules*/

charis(P, Val):-ask('Does the Bird is',Val).
ask(Obj, Val):-known(Obj, Val, true),!.
ask(Obj, Val):-known(Obj, Val, false),!, fail.
ask(Obj, Val):-nl,write(Obj),write(' '),
			write( Val) , write('?(y/n)'), read(Ans), !,
			((Ans=y, assert(known(Obj, Val, true)));(assert(known(Obj, Val, false)),fail)).

findtype:-nl,write('findind type of bird..........'),nl,bird(charis,Bird) ,!,nl,
			write('That bird could be '), write(Bird).
findtype:- nl, write('Sorry,we may not be able to find bird type!!').

start:-notice,repeat, abolish(known/3),dynamic(known/3), retractall(known/3), findtype,nl,nl, write('Try again ? (y/n)'),read(Resp),\+ Resp=y,
		nl,write('Bye ! Thanks for using this system'),abolish(known,3) .

