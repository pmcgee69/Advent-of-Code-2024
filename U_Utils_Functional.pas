unit U_Utils_Functional;

interface
uses Generics.Collections, System.SysUtils, System.Classes, System.Math;

const
    minint = -maxint;
type
    UFP = record
      type
        tuple <A,B>   = record fst : A;
                               snd : B;
                               constructor Create(_a:a; _b:B);
                        end;
        triple<A,B,C> = record fst : A; snd : B; thd : C; end;

      class function List_Map    <U>     ( L : TStringList; f : TFunc<string,U> )  : TList<U>;    overload;   static;
      class function List_Map    <T,U>   ( L : TList<T>;    f : TFunc<T,U> )       : TList<U>;    overload;   static;

      class function String_Map  <U>     ( const s: string; f : TFunc<string, integer, U> )
                                                                                   : TList<U>;                static;

      class function List_Reduce <T>     ( L : TList<T>;    f : TFunc<T,T,T>; t_:T): T;                       static;

      class function List_Filter <T>     ( L : TList<T>;    f : TPredicate<T> )    : TList<T>;                static;

      class function Compose  <T,U,V>    ( f : TFunc<T,U>;  g : TFunc<U,V> )       : TFunc<T,V>;              static;
      class function Compose3 <T,U,V,W>  ( f : TFunc<T,U>;
                                           g : TFunc<U,V>;  h : TFunc<V,W> )       : TFunc<T,W>;              static;

      class function Zip         <T,U>   ( L1 : TList<T>;   L2 : TList<U> )        : TList< tuple<T,U> >;     static;
      class function ZipTransform<T,U,V> ( L1 : TList<T>;
                                           L2 : TList<U>;   f  : TFunc<T,U,V> )    : TList<V>;    overload;   static;
      class function ZipTransform<T,U,V> ( L1 : TArray<T>;
                                           L2 : TArray<U>;  f  : TFunc<T,U,V> )    : TList<V>;    overload;   static;

      class function Order       <T>     ( L  : TList<T> )                         : TList<T>;                static;

      class function Adj_Diff            ( A  : TArray<integer> )                  : TList<integer>;          static;
      class function Adj_Delta           ( A  : TArray<integer> )                  : TList<integer>;          static;

      class function Take        <T>     ( L  : TList<T>;   n  : integer )         : TList<T>;                static;
      class function Leave       <T>     ( L  : TList<T>;   n  : integer )         : TList<T>;                static;

    end;




  function SafeStrToInt(s : string)  : integer;

  function StringToInt (s : string ) : integer;

  function Sum      ( i,j : integer) : integer;

  function Diff     ( i,j : integer) : integer;

  function Delta    ( i,j : integer) : integer;

  function Mult     ( i,j : integer) : integer;

  function Max      ( i,j : integer) : integer;

  function Min      ( i,j : integer) : integer;


implementation
   constructor UFP.tuple<A,B>.Create(_a: A; _b: B);
   begin
        fst := _a;
        snd := _b;
   end;

   class function UFP.List_Map<T,U> ( L : TList<T>; f : TFunc<T,U> ) : TList<U>;
   begin
     var L2 := TList<U>.create;

         for var T_ in L do L2.Add( f(T_) );

         result := L2;
   end;


   class function UFP.List_Map<U> ( L : TStringList; f : TFunc<string,U> ) : TList<U>;
   begin
     var L2 := TList<U>.create;

         for var T_ in L do L2.Add( f(T_) );

         result := L2;
   end;


   class function UFP.String_Map<U> ( const s : string; f : TFunc<string, integer, U> ) : TList<U>;
   begin
     var L2 := TList<U>.create;

         for var i := 1 to length(s) do L2.Add( f(s, i) );

         result := L2;
   end;


   class function UFP.List_Reduce<T> ( L : TList<T>; f : TFunc<T,T,T>; t_:T ) : T;
   begin
         case gettypekind(T) of
            tkInteger :  result := t_ ;
            else         result := default(T);
         end;

         for var x in L do result := f(x, result);
   end;



   class function UFP.List_Filter<T> ( L : TList<T>; f : TPredicate<T> ) : TList<T>;
   begin
     var L2 := TList<T>.create;

         for var T_ in L do if f(T_) then L2.Add(T_);

         result := L2;
   end;



   class function UFP.Compose <T,U,V> ( f : TFunc<T,U>; g : TFunc<U,V> ) : TFunc<T,V>;
   begin
         result := function( _t : T ) : V
                   begin
                      result := g( f( _t ) )
                   end;
   end;



   class function UFP.Compose3 <T,U,V,W> ( f : TFunc<T,U>; g : TFunc<U,V>; H : TFunc<V,W> ) : TFunc<T,W >;
   begin
         result := function( _t : T ) : W
                   begin
                      result := h( g( f( _t ) ) )
                   end;
   end;


   class function UFP.Zip <T,U> ( L1:TList<T>; L2:TList<U> ) : TList< tuple<T,U> >;
   begin
     var L3 := TList< tuple<T,U> >.create;
     var i  := 0;

         if L1.Count = L2.Count then
            while i<L1.Count do begin
              var x := UFP.tuple<T,U>.Create( L1[i], L2[i] );
                  L3.Add( x );
                  inc(i);
            end;
         result := L3;
   end;


   class function UFP.ZipTransform <T,U,V> ( L1:TList<T>;
                                             L2:TList<U>; f:TFunc<T,U,V> ) : TList<V>;
   begin
     var L3 := TList<V>.create;
     var i  := 0;

         if L1.Count = L2.Count then
            while i<L1.Count do begin
                  L3.Add( f(L1[i],L2[i]) );
                  inc(i);
            end;
         result := L3;
   end;


   class function UFP.ZipTransform <T,U,V> ( L1:TArray<T>;
                                             L2:TArray<U>; f:TFunc<T,U,V> ) : TList<V>;
   begin
     var L3 := TList<V>.create;
     var i  := 0;

         if length(L1) = length(L2) then
            while i<length(L1) do begin
                  L3.Add( f(L1[i],L2[i]) );
                  inc(i);
            end;
         result := L3;
   end;


   class function UFP.Order <T> ( L:TList<T> ) : TList<T>;
   begin
         L.Sort;
         result := L;
   end;


   class function UFP.Adj_Diff ( A:TArray<integer> ) : TList<integer>;
   begin
     var L    := TList<integer>.create;
     var last := 0;

         for var x in A do begin
             L.Add( x-last );
             last := x;
         end;
         result := L;
   end;


   class function UFP.Adj_Delta ( A:TArray<integer> ) : TList<integer>;
   begin
     var L    := TList<integer>.create;
     var last := 0;

         for var x in A do begin
             L.Add( abs(x-last) );
             last := x;
         end;
         result := L;
   end;


   class function UFP.Take <T> ( L:TList<T>; n:integer ) : TList<T>;
   begin
     var L_ := TList<T>.create;
     var k  := min(n,L.Count);

         for var i:=0 to k-1 do L_.Add(L[i]);

         result := L_;
   end;


   class function UFP.Leave <T> ( L:TList<T>; n:integer ) : TList<T>;
   begin
     var L_ := TList<T>.create;

         for var i:=n to L.Count-1 do L_.Add(L[i]);

         result := L_;
   end;


// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

   function SafeStrToInt(   s : string ) : integer;   begin  if s='' then exit(0) else exit(s.ToInteger)  end;

   function StringToInt (   s : string ) : integer;   begin  exit( s.ToInteger ) end;

   function Sum         ( i,j : integer) : integer;   begin  exit( i+j )         end;

   function Diff        ( i,j : integer) : integer;   begin  exit( i-j )         end;

   function Delta       ( i,j : integer) : integer;   begin  exit( abs(i-j) )    end;

   function Mult        ( i,j : integer) : integer;   begin  exit( i*j )         end;

   function Max         ( i,j : integer) : integer;   begin  if i<j then exit(j) else exit(i)  end;

   function Min         ( i,j : integer) : integer;   begin  if i<j then exit(i) else exit(j)  end;


end.




