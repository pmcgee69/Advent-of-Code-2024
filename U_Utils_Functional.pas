unit U_Utils_Functional;

interface
uses generics.Collections, system.SysUtils, system.classes;

type
    UFP = record
      type
        tuple <A,B>   = record fst : A;
                               snd : B;
                               constructor Create(_a:a; _b:B);
                        end;
        triple<A,B,C> = record fst : A; snd : B; thd : C; end;

      class function List_Map    <U>     ( L : TStringList; f : TFunc<string,U> ) : TList<U>;    overload;   static;

      class function List_Map    <T,U>   ( L : TList<T>;    f : TFunc<T,U> )      : TList<U>;    overload;   static;

      class function List_Reduce <T>     ( L : TList<T>;    f : TFunc<T,T,T> )    : T;                       static;

      class function List_Filter <T>     ( L : TList<T>;    f : TPredicate<T> )   : TList<T>;                static;

      class function Compose  <T,U,V>    ( f : TFunc<T,U>;  g : TFunc<U,V> )      : TFunc<T,V>;              static;

      class function Compose3 <T,U,V,W>  ( f : TFunc<T,U>;
                                           g : TFunc<U,V>;  h : TFunc<V,W> )      : TFunc<T,W>;              static;

      class function String_Map  <U>     ( const s : string;f : TFunc<string, integer, U> ) : TList<U>;      static;


      class function Zip         <T,U>   ( L1 : TList<T>;   L2 : TList<U> )       : TList< tuple<T,U> >;     static;

      class function ZipTransform<T,U,V> ( L1 : TList<T>;
                                           L2 : TList<U>;   f  : TFunc<T,U,V> )   : TList<V>;    overload;   static;

      class function ZipTransform<T,U,V> ( L1 : TArray<T>;
                                           L2 : TArray<U>;  f  : TFunc<T,U,V> )   : TList<V>;    overload;   static;

      class function Order       <T>     ( L  : TList<T> )                        : TList<T>;                static;

    end;




  function SafeStrToInt(s : string)  : integer;

  function StringToInt (s : string ) : integer;

  function Sum      ( i,j : integer) : integer;

  function Diff     ( i,j : integer) : integer;

  function Delta    ( i,j : integer) : integer;

  function Mult     ( i,j : integer) : integer;

  function Max      ( i,j : integer) : integer;



implementation
   constructor UFP.tuple<A,B>.Create(_a: A; _b: B);
   begin
        fst := _a;
        snd := _b;
   end;

   class function UFP.List_Map<T,U> ( L : TList<T>; f : TFunc<T,U> ) : TList<U>;
   begin
     var L2 {: TList<U>} := TList<U>.create;

         for var T_ in L do L2.Add( f(T_) );

         result := L2;
   end;


   class function UFP.List_Map<U> ( L : TStringList; f : TFunc<string,U> ) : TList<U>;
   begin
     var L2 {: TList<U>} := TList<U>.create;

         for var T_ in L do L2.Add( f(T_) );

         result := L2;
   end;


   class function UFP.String_Map<U> ( const s : string; f : TFunc<string, integer, U> ) : TList<U>;
   begin
     var L2 {: TList<U>} := TList<U>.create;

         for var i := 1 to length(s) do L2.Add( f(s, i) );

         result := L2;
   end;


   class function UFP.List_Reduce<T> ( L : TList<T>; f : TFunc<T,T,T> ) : T;
   begin
         result := default(T);

         for var t_ in L do result := f(t_, result);
   end;



   class function UFP.List_Filter<T> ( L : TList<T>; f : TPredicate<T> ) : TList<T>;
   begin
     var L2 {: TList<T>} := TList<T>.create;

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

         if L1.Count = L2.Count then begin
            var i := 0;
            while i<L1.Count do begin
              var x := UFP.tuple<T,U>.Create( L1[i], L2[i] );
                  L3.Add( x );
                  inc(i);
            end;
         end;
         result := L3;
   end;

   class function UFP.ZipTransform <T,U,V> ( L1:TList<T>;
                                             L2:TList<U>; f:TFunc<T,U,V> ) : TList<V>;
   begin
     var L3 := TList<V>.create;

         if L1.Count = L2.Count then begin
            var i := 0;
            while i<L1.Count do begin
                  L3.Add( f(L1[i],L2[i]) );
                  inc(i);
            end;
         end;
         result := L3;
   end;

   class function UFP.ZipTransform <T,U,V> ( L1:TArray<T>;
                                             L2:TArray<U>; f:TFunc<T,U,V> ) : TList<V>;
   begin
     var L3 := TList<V>.create;

         if length(L1) = length(L2) then begin
            var i := 0;
            while i<length(L1) do begin
                  L3.Add( f(L1[i],L2[i]) );
                  inc(i);
            end;
         end;
         result := L3;
   end;

   class function UFP.Order <T> ( L:TList<T> ) : TList<T>;
   begin
         L.Sort;
         result := L;
   end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

   function SafeStrToInt(   s : string ) : integer;   begin  if s='' then exit(0) else exit(s.ToInteger)  end;

   function StringToInt (   s : string ) : integer;   begin  exit( s.ToInteger ) end;

   function Sum         ( i,j : integer) : integer;   begin  exit( i+j )         end;

   function Diff        ( i,j : integer) : integer;   begin  exit( i-j )         end;

   function Delta       ( i,j : integer) : integer;   begin  exit( abs(i-j) )    end;

   function Mult        ( i,j : integer) : integer;   begin  exit( i*j )         end;

   function Max         ( i,j : integer) : integer;   begin  if i<j then exit(j) else exit(i)  end;



end.




