//: Playground - noun: a place where people can play

import UIKit
import Accelerate

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

public func max1 (a: [Double]) -> Double {
    //Vector maximum magnitude; double precision.
    var result = 0.0
    vDSP_maxmgvD(a,1,&result,UInt(a.count))
    return result
}


func db (a: [Double], max: Double) -> [Double] {
    //Vector maximum magnitude; double precision.
    
    var result=[Double](repeating:0.0, count: a.count )
    var max2=max
    
    
    /*__A
     Single-precision real input vector
     __IA
     Stride for A
     __B
     Pointer to single-precision real input scalar: zero reference
     __C
     Single-precision real output vector
     __IC
     Stride for C
     __N
     The number of elements to process
     __F
     Power (0) or amplitude (1) flag*/
    vDSP_vdbconD(a, 1, &max2, &result, 1, UInt(a.count), 1)
    return result
}



//test


let z=SIGN(a: 1.0, b: 5.0)

print(z)

func Hjw (aBot: [Double],bTop: [Double],gain: Double, lPoints: Int) -> (Mag:[Double], MagDB:[Double], Phase:[Double],Omega:[Double]) {//start
    
    let mTopNum=bTop.count
    let nBotNum=aBot.count
    
    
    var HMAG=[Double](repeating:0.0, count: lPoints)
    var HPHA=[Double](repeating:0.0, count: lPoints)
    var Omega=[Double]()
    
    var eJW1=Complex(r:0.0,j:0.0)
    var eJW=Complex(r:0.0,j:0.0)
    var eJWK=Complex(r:0.0,j:0.0)
    var HW=Complex(r: 0,j: 0)
    var HWN=Complex(r: 0,j: 0)
    var HWD=Complex(r: 0,j: 0)
    var G1=Complex(r: 0,j: 0)
    var B1=Complex(r: 0,j: 0)
    var A1=Complex(r: 0,j: 0)
    var DW:Double=0.0
    
    let EPS=1.0e-7
    var x:Double=0.0
    
    
    
    if lPoints>1{//start if
        DW=pi/Double(lPoints-1)
    }//end if
    
    for i in (0..<lPoints){//start for i
        x=(-Double(i)*DW)
        
        print("\nomega=\(x)")
        Omega.append(x)
        
        eJW1.r=0.0
        eJW1.j=x
        eJW=CEXP(c1: eJW1)
        print("eJW=\(eJW)")
        
        HWN.r=0.0
        HWN.j=0.0
        
        print("\nHWN=\(HWN)")
        eJWK.r=1.0
        eJWK.j=0.0
        print("eJWK=\(eJWK)")
        
        for z in (0..<mTopNum){//start for index
            B1.r=bTop[z]
            B1.j=0.0
            eJWK=B1*eJWK
            print("eJWK[\(z)]=\(eJWK)")
          
            HWN=HWN+eJWK
            print("HWN[\(z)]=\(HWN)")
            
            
        }//end for index 100

        HWD.r=1.0
        HWD.j=0.0
        print("HWD=\(HWD)")
        
        eJWK=eJW
        print("eJWK=\(eJWK)")
        
        for p in (0..<nBotNum){//for index1
            A1.r=aBot[p]
            A1.j=0.0
            eJWK=A1*eJWK
            print("eJWK[\(p)]=\(eJWK)")
            
            HWD=HWD+eJWK
            
            print("HWD[\(p)]=\(HWD)")
            eJWK=eJWK*eJW
            print("eJWK[\(p)]=\(eJWK)")
            
        }//end index1 200

        G1.r=gain
        G1.j=0.0
        HWN=HWN*G1
        
         print("HWN=\(HWN)")
        print("HWD=\(HWD)")
        HW=HWN/HWD
          print("HW=\(HW)")

        
        if abs(HW.r)<EPS && abs(HW.j)<EPS {//start if1
            if i>2 {//start if2
                HPHA[i]=2.0*HPHA[i-1]-HPHA[i-2]
            }//end if2
            else if abs(HW.r)<EPS{//start else if
            
                HPHA[i]=SIGN(a: 1.0, b: HW.j)*0.5*pi
            }//end else if
                  }//end if1
            else
            {//start else
                
                let IX=(1.0-SIGN(a: 1.0, b: HW.r))/2.0
                let IY=SIGN(a: 1.0, b: HW.j)
                HPHA[i]=atan(HW.j/HW.r)+IX*IY*pi
            }//end else
            
      
        HMAG[i]=CABS(c1: HW)
        
        
        
        



     }//end for i 300
    
    
    let max=max1(a: HMAG)
    let out=db(a: HMAG, max: max)
    
    return (Mag:HMAG,MagDB:out,Phase:HPHA,Omega:Omega)
}//end


let A=[-0.8]
let B=[1.0,0.0]
let gain=1.0
let points=4

let output=Hjw(aBot: A, bTop: B, gain: gain, lPoints: points)

let mag=output.Mag
let phase=output.Phase

let omega=output.Omega

let db1=output.MagDB
