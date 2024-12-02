pub fn main() {
    let mut vec1 = DATA1;
    let mut vec2 = DATA2;

    vec1.sort();
    vec2.sort();

    let result:i32 = vec1.iter()
                         .zip(vec2.iter())
                         .map(|(x, y)| diff(x,y))
                         .sum();

    println!("Difference sum: {}", result);
}

fn diff(x: &i32, y: &i32) -> i32 { (x-y).abs() }

pub static DATA1 : [i32; 11] = 
[   
    17113,
    55260,
    92726,
    79691,
    97979,
    28198,
    33527,
    22794,
    54386,
    28290,
    72856
];

pub static DATA2 : [i32; 11] = 
[   
    23229,
    78804,
    24891,
    90526,
    99871,
    44110,
    52030,
    55253,
    67440,
    47430,
    96191        
];