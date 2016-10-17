//: Playground - noun: a place where people can play

import UIKit
let pi = 4.0*atan(1.0)

struct Complex {
    var r:Double = 0.0, j:Double = 0.0
}

/*************functions**********/


func printComplex (c1: Complex) {
    print("r=\(c1.r) j=\(c1.j)")
    
}

func SIGN (a:Double, b:Double)-> Double {
    
    //If B\ge 0 then the result is ABS(A), else it is -ABS(A)
    var out:Double=0.0
    if b>0{
        out=abs(a)
    }
    else{
        out = -abs(a)
    }
    return out
    
}

func + (c1: Complex, c2: Complex) -> Complex {
    return Complex(r: c1.r + c2.r, j: c1.j + c2.j)
}
func - (c1: Complex, c2: Complex) -> Complex {
    return Complex(r: c1.r - c2.r, j: c1.j - c2.j)
}

func CABS (c1: Complex) -> Double {
    var out :Double = 0.0
    out=sqrt(c1.r*c1.r+c1.j*c1.j)
    return out
}

func angFunction (c1: Complex) -> (rad:Double, deg:Double) {
    var rad :Double = 0.0
    let pi :Double = 4.0*atan(1.0)
    //let ratio1 = c1.j/c1.r
    let angle1 = atan2(c1.j,c1.r)
    rad=(angle1)
    let deg=rad*180/pi
    return (rad, deg)
}

func * (c1: Complex, c2: Complex) -> Complex {
    var out = Complex(r:0.0, j:0.0)
    out.r=c1.r*c2.r-c1.j*c2.j
    out.j=c1.r*c2.j+c1.j*c2.r
    return out }

func / (c1: Complex, c2: Complex) -> Complex {
    var out = Complex(r:0.0, j:0.0)
    let bottom = pow(c2.r,2)+pow(c2.j,2)
    out.r=(c1.r*c2.r+c1.j*c2.j)/bottom
    out.j=(c1.j*c2.r-c1.r*c2.j)/bottom
    return out }

func MagToRect (m1: MagAng ) -> Complex {
    var out = Complex(r:0.0, j:0.0)
    out.r = m1.mag * cos(m1.ang)
    out.j = m1.mag * sin(m1.ang)
    return out }

//: ![Functions 1 - Programming Examples](CEXP.tiff)
func CEXP (c1: Complex)-> Complex{
    var out=Complex(r: 0.0,j: 0.0)
    //exp(a+jb)=e^a(cos(w)+jsin(w))
    out.r=exp(c1.r)*cos(c1.j)
    out.j=exp(c1.r)*sin(c1.j)
    return out
}

struct MagAng {
    var mag = 0.0, ang = 0.0
}

//test
var HW=Complex(r: 0.0,j: 1.0)
var HWN=Complex(r: 1.0,j: 1.0)
var HWD=Complex(r: 0,j: 0)


let y = CEXP(c1: HW)
let x = HW*HWD

print(x)

let z=SIGN(a: 1.0, b: 5.0)

print(z)

