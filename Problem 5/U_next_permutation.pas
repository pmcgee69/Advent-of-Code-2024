unit U_next_permutation;

// Algorithm from C++ Standard Template Library
// 1994-96 HP SGI
// https://github.com/karottc/sgi-stl/blob/master/stl_algo.h
// gnu libstdc++ 4.7 stl_algo.h

interface
uses
   System.Generics.Collections;

function  Next_Permutation( var L:TList<integer> ) : boolean;

procedure Reverse         ( var L:TList<integer>; a,b:word );

procedure Test_Perm;


implementation


procedure Swap(var L:TList<integer>; a,b:word);
begin
    var c := L[a];   L[a] := L[b];   L[b] := c;
end;


procedure Reverse(var L:TList<integer>; a,b:word);     // a,b iterators  (position pointers)
begin
    if a = b-1 then exit;

    var j := trunc((b-a)/2);                           // 0..5   ->  2

    for var i := 0 to j-1 do Swap(L, a+i, b-i-1);
end;


function Next_Permutation( var L:TList<integer> ) : boolean;
var
	i, ii, j, k, p : word;
begin
 var first := 0;
 var last  := L.Count;

	if first   = last then exit(false);
	if first+1 = last then exit(false);
	     i    := last - 1;

	repeat begin
		ii := i;  dec(i);

		if L[i] < L[ii] then begin

			j := last;
			repeat
              dec(j);
			until  L[i] < L[j];

			Swap(L,i,j);

			reverse(L, ii, last);
			exit(true);
		end;

		if i = first then begin
			reverse(L, first, last);
			exit(false);
		end;
	end
	until false;
end;


procedure Test_Perm;
begin
       var L     := TList<integer>.Create;
//     var check := prints[23].split([',']);
//     for var x in check do L.Add(x.ToInteger);

//     L.add(5); L.add(4); L.add(3); L.add(2); L.add(1);                                 // immediate
//     L.add(64); L.add(47); L.add(99); L.add(48); L.add(84);
//     L.add(34); L.add(46); L.add(26); L.add(88); L.add(72); L.add(71); L.add(52); L.add(93); L.add(47);

       L.add(79); L.add(99); L.add(31); L.add(72); L.add(34); L.add(11);                   // 2 seconds
       L.add(43); L.add(42); L.add(39); L.add(52); L.add(32);
       L.add(77);    // longer
       L.add(93);    // loooonger
     //L.Sort;
       for var x in L do write(x, ' '); writeln;

//     reverse(L,0,5);  writeln;
//     for var x in L do write(x, ' '); writeln;

       var i:=0;
       while Next_Permutation(L) do begin
             inc(i);
             //for var x in L do write(x, ' ');
             //writeln;
       end;
       writeln;
       writeln(i,'.');
       readln;
end;

end.
