unit U_Patterns;

interface


implementation

{   Check for 1 word  in 8 directions ...
           or 2 words in 4 directions.

// - - - - - - - - - - - - - - - -

    "xmas", "samx"

    . . . . . . .      . . . s . . .     s . . . . . .       . . . . . . s     . . . . . . .
    . . . . . . .      . . . a . . .     . a . . . . .       . . . . . a .     . . . . . . .
    . . . . . . .      . . . m . . .     . . m . . . .       . . . . m . .     . . . . . . .
    s a m x m a s      . . . x | . .     . . \ x . . .       . . . x / . .     . . . ○ . . .
    . . . = = = =      . . . m | . .     . . . \ m . .       . . m / . . .     . . . . . . .
    . . . . . . .      . . . a | . .     . . . . \ a .       . a / . . . .     . . . . . . .
    . . . . . . .      . . . s | . .     . . . . . \ s       s / . . . . .     . . . . . . .

    m . s . m . m
    . a . . . a .
    m . s . s . s
    . . . . . . .
    s . s . s . m
    . a . . . a .
    m . m . s . m


}

end.

