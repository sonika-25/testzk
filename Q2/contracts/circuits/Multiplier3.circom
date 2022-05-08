pragma circom 2.0.0;

// [assignment] Modify the circuit below to perform a multiplication of three signals
 template Multiplier () {
    signal input int1;
    signal input int2;
    signal output int3;

    int3 <== int1 * int2;
 }
 template Multiplier3 () {  

   // Declaration of signals.  
   signal input a;  
   signal input b;
   signal input c;
   signal output d;  
   
   component multiA = Multiplier();
   component multiB = Multiplier();
   multiA.int1 <== a;
   multiA.int2 <== b;
   multiB.int1 <== multiA.int3;
   multiB.int2 <== c;
   // Constraints.  
   d <== multiB.int3;  
}

component main = Multiplier3();