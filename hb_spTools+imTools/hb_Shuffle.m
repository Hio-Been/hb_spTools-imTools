function shuffled_v = hb_Shuffle(v)
shuffled_v = v([hb_randperm(length(v))]);
return
function perm = hb_randperm(N)
%  USAGE -> perm= hb_randperm(N)
%  perm = hb_randperm(N) returns a vector containing a random permutation of the
%    integers 1:N.  For example, randperm(6) might be [2 4 5 6 1 3].
% 
[~, perm]=sort(rand([N,1]));
return

