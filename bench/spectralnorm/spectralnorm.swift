/* The Computer Language Benchmarks Game
   http://benchmarksgame.alioth.debian.org/
   contributed by Isaac Gouy 
*/

import CoreFoundation


func approximate(n: Int) -> Double {
   var u = Array(count: n, repeatedValue: 1.0) 

   var v = Array(count: n, repeatedValue: 0.0) 
   for _ in 1...10 {
      multiplyAtAv(n,u,&v)
      multiplyAtAv(n,v,&u)
   }
 
   var vBv = 0.0, vv = 0.0
   for i in 0...n-1 {
      vBv += u[i]*v[i]
      vv  += v[i]*v[i]
   }

   return sqrt(vBv/vv)
}

func a(i: Int, _ j: Int) -> Double {
   let ij = i+j
   return 1.0 / Double( ij*(ij+1)/2 + i+1 ) 
}

func multiplyAv(n: Int, _ v: [Double], inout _ av: [Double]) {
   for i in 0...n-1 {
      av[i] = 0.0;
      for j in 0...n-1 {
         av[i] += a(i,j)*v[j] 
      }
   }
}

func multiplyAtv(n: Int, _ v: [Double], inout _ atv: [Double]) {
   for i in 0...n-1 {
      atv[i] = 0;
      for j in 0...n-1 {
         atv[i] += a(j,i)*v[j] 
      }
   }
}

func multiplyAtAv(n: Int, _ v: [Double], inout _ atAv: [Double]) {
   var u = Array(count: n, repeatedValue: 0.0) 
   multiplyAv(n,v,&u)
   multiplyAtv(n,u,&atAv)
}


let n: Int = Int(Process.arguments[1])!
print( String(format: "%.9f", approximate(n)) )

