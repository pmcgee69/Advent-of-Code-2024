unit U_Bad_Shuffle;

interface

function bad_reshuffle ( check : TArray<string> ) : boolean;

implementation
uses System.SysUtils, System.Generics.Collections, Problem_5_Data, U_next_permutation;


//   ----    ----    ----    ----

function ordered_L( check : TList<integer> ):boolean;
begin
    var lint    :  TList<integer>;
    var current := check[0];
    var ok      := false;
    var i       := 0;
        repeat
            if graph.TryGetValue( current, lint) then
               inc(i);
               current := check[i];
               ok      := lint.Contains( current );
        until not ok or (i=check.Count-1);
        exit(ok);
end;


function bad_reshuffle( check : TArray<string> ) : boolean;
begin
    var p :=TList<integer>.Create;
        for var s in check do p.Add(s.ToInteger);
        p.sort;

        result := false;
        while not result and Next_Permutation( p ) do
              if ordered_L( p ) then result:=true;

        for var i := 0 to high(check) do
              check[i] := p[i].ToString;
end;


end.
