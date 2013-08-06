/*

  Calculs d'enfer puzzle in ECLiPSe.

 
  Problem from Jianyang Zhou "The Manual of NCL version 1.2", page 33
  http://citeseer.ist.psu.edu/161721.html
  
  The solution is the manual is:
  """
  a = -16, b = -14, c = -13, d = -12, e = -10,
  f = 4, g = 13, h = -1, i = -3, j = -11, k = -9,
  l = 16, m = -8, n = 11, o = 0, p = -6, q = -4,
  r = 15, s = 2, t = 9, u = -15, v = 14, w = -7,
  x = 7, y = -2, z = -5.
 
  max_{#1\in [1,26]}{|x_{#1}|} minimized to 16
  """
 
  Also, see the discussion of the Z model:
  http://www.comp.rgu.ac.uk/staff/ha/ZCSP/additional_problems/calculs_enfer/calculs_enfer.ps
  (which shows the same solution).

  And compare with the following models:
  * MiniZinc: http://www.hakank.org/minizinc/calculs_d_enfer.mzn
  * Comet   : http://www.hakank.org/comet/calculs_d_enfer.co


  Model created by Hakan Kjellerstrand, hakank@bonetmail.com
  See also my ECLiPSe page: http://www.hakank.org/eclipse/

*/

:-lib(ic).
:-lib(ic_global).
:-lib(ic_search).
:-lib(branch_and_bound).
% :-lib(propia).


go :-
        NN = 26,

        AA = [](A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z),
        AA :: -100..100,
        
        % The objective is to minimize the maximum of the absolute 
        % values of [i]
        dim(Aabs, [NN]),
        ( for(II, 1,NN), param(AA,Aabs) do
              Aabs[II] #= abs(AA[II])
        ),


        % we want to minimize the maximum value in AA
        Amax :: 0..NN,
        Amax #= max(Aabs),
        
        ic_global:alldifferent(AA),

        Z+E+R+O     #= 0,
        O+N+E       #= 1,
        T+W+O       #= 2,
        T+H+R+E+E   #= 3,
        F+O+U+R     #= 4,
        F+I+V+E     #= 5,
        S+I+X       #= 6,
        S+E+V+E+N   #= 7,
        E+I+G+H+T   #= 8,
        N+I+N+E     #= 9,
        T+E+N       #= 10,
        E+L+E+V+E+N #= 11,
        T+W+E+L+F   #= 12,
        
        % search
        collection_to_list(AA, Vars),
        minimize(search(Vars,0,first_fail,indomain,complete,[]), Amax),

        % for generating more solutions (there are _many_)
        % Amax #=< 16,
        % search(Vars,0,first_fail,indomain,complete,[]),


        writeln(amax:Amax),
        writeln(AA).



