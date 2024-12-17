unit U_Shuffle;

interface
uses System.SysUtils, System.Generics.Collections, Problem_5_Data;


function ordered   ( check : TArray<string> ) : boolean;
function map_chains( pages : TArray<string> ) : integer;



implementation
uses U_Utils_Functional; //, WC_ArrayHelper;


function ordered( check : TArray<string> ):boolean;
begin
    var lint    :  TList<integer>;
    var current := check[0].ToInteger;
    var ok      := false;
    var i       := 0;
        repeat
            if graph.TryGetValue( current, lint) then
               inc(i);
               current := check[i].ToInteger;
               ok      := lint.Contains( current );
        until not ok or (i=high(check));
        exit(ok);
end;




function map_chains( pages : TArray<string> ) : integer;
begin
    var lint    :  TList<integer>;
//    var current := p[0].ToInteger;
//    var ok      := false;
//    var i       := 0;

//    var chains  := TList< TList<integer> >.Create;
//    var chain   := TList<integer>.Create([current]);
//        chains.add(chain);

        // restrict down to edges over the set of nodes { p }
        // chains = histogram of edges for {e₁ ∈ p} { e₂ : (e₁,e₂) }
{        repeat
        //  write(current, ' ');
            if graph.TryGetValue( current, lint) then
               inc(i);
               current := p[i].ToInteger;
               ok      := lint.Contains( current );

               if ok then chain.add(current)
                     else begin
                             chain := TList<integer>.Create([current]);
                             chains.add(chain);
                          end;
               if not ok then writeln;
        until (i=high(p));
        writeln;
        writeln;
}
        // edges2 = filter edges for { e₁,e₂ ∈ p }
//    var edges2 := TList< tuple >.Create;
//        for var e in edges do begin
//               var ab := e.Split(['|']);
//               var a  := ab[0];
//               var b  := ab[1];
//
//               if TArray.Contains<string>(p,a) and
//                  TArray.Contains<string>(p,b) then
//                         edges2.Add( tuple.Create(a.ToInteger, b.ToInteger));
//        end;

//      writeln;
//      for var e in edges2  do  writeln(e.fst, '   ', e.snd);        // filtered edges
//      writeln;

        // Partition filtered edges data by initial node
//    var nodes    := TList< integer >.Create;
//        for var e in edges2 do
//            if not nodes.Contains(e.fst) then
//               begin
//                  nodes.Add(e.fst);
//                  graph.TryGetValue(e.fst, lint);
//                  lint.sort;
//                  write(e.fst, ' :  ');
//                  for var x in lint do
//                      if TArray.Contains<string>(p,x.ToString) then write(x,' ');
//                  writeln;
//               end;

    var connects:= TList< UFP.TupleInt >.Create;
        for var page in pages do
               begin
                  graph.TryGetValue(page.ToInteger, lint);
                  var x := UFP.List_Filter<integer>( lint, function(x:integer):boolean
                                                           begin
                                                              result := TArray.Contains<string>(pages,x.ToString)
                                                           end )
                                                   .Count;
                  //writeln( page, ' :  ', x);
                  connects.Add( UFP.TupleInt.Create(page.ToInteger,x) );
               end;
        connects.Sort( UFP.TupleInt_Comp_Snd.Create );
//        writeln;
//        for var x in connects do writeln(x.fst, ' : ', x.snd);
        result := connects[ trunc(connects.Count/2) ].fst;
end;


end.


