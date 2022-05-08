#!/bin/bash

cd contracts/circuits

mkdir Multiplier3_plonk
# [assignment] create your own bash script to compile Multipler3.circom using PLONK below

if [ -f ./powersOfTau28_hez_final_10.ptau ]; then
    echo "powersOfTau28_hez_final_10.ptau already exists. Skipping."
else
    echo 'Downloading powersOfTau28_hez_final_10.ptau'
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_10.ptau
fi

echo "Compiling Multiplier3.circom..."

# compile circuit
circom Multiplier3.circom --r1cs --wasm --sym -o Multiplier3_plonk

snarkjs r1cs info Multiplier3_plonk/Multiplier3.r1cs

# Start a new zkey and make a contribution
#snarkjs plonk setup circuit.r1cs pot12_final.ptau circuit_final.zkey
#snarkjs zkey verify circuit.r1cs pot12_final.ptau circuit_final.zkey
#snarkjs zkey export verificationkey circuit_final.zkey verification_key.json

snarkjs plonk setup Multiplier3_plonk/Multiplier3.r1cs powersOfTau28_hez_final_10.ptau Multiplier3_plonk/circuit_0000.zkey
#snarkjs zkey contribute Multiplier3_plonk/circuit_0000.zkey Multiplier3_plonk/circuit_final.zkey --name="1st Contributor Name" -v -e="random text"
#snarkjs zkey verify Multiplier3_plonk/circuit_0000.zkey powersOfTau28_hez_final_10.ptau circuit_final.zkey
snarkjs zkey export verificationkey Multiplier3_plonk/circuit_0000.zkey Multiplier3_plonk/verification_key.json

# generate solidity contract
snarkjs zkey export solidityverifier Multiplier3_plonk/circuit_0000.zkey ../Multiplier3_plonk.sol

cd ../..