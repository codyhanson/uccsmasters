#! /usr/bin/env python

#perform the MixCols step in the AES cipher.

from BitVector import BitVector as bv

n = 8 #for GF(2^8)

#modulus for AES
#x^8 + x^4 + x^3 + x + 1
m = bv(bitlist = [1,0,0,0,1,1,0,1,1])

col00 = bv(intVal=0x7C,size = 8)
col01 = bv(intVal=0xF2,size = 8)
col02 = bv(intVal=0x2B,size = 8)
col03 = bv(intVal=0xAB,size = 8)


bv2 = bv(intVal=2, size = 8)
bv3 = bv(intVal=3, size = 8)

newcol00 = col00.gf_multiply_modular(bv2,m,n) ^ col01.gf_multiply_modular(bv3,m,n) ^ col02 ^ col03
newcol01 = col01.gf_multiply_modular(bv2,m,n) ^ col02.gf_multiply_modular(bv3,m,n) ^ col00 ^ col03
newcol02 = col02.gf_multiply_modular(bv2,m,n) ^ col03.gf_multiply_modular(bv3,m,n) ^ col00 ^ col01
newcol03 = col03.gf_multiply_modular(bv2,m,n) ^ col00.gf_multiply_modular(bv3,m,n) ^ col02 ^ col01

print newcol00.getHexStringFromBitVector()
print newcol01.getHexStringFromBitVector()
print newcol02.getHexStringFromBitVector()
print newcol03.getHexStringFromBitVector()
