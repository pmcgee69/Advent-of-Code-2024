
fn diff(x: &i32, y: &i32) -> i32 {  (x-y).abs()  }

pub fn main() {
    let mut vec1 = vec![1, 4, 2, 8i32];
    let mut vec2 = vec![3, 6, 5, 7];

    vec1.sort();
    vec2.sort();

    let result:i32 = vec1.iter() . zip(vec2.iter())
                                 . map(|(x, y)| diff(x,y) )
                                 . sum();

    println!("Difference sum: {}", result);
}