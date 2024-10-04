li x21 0x1560
addi x1,x0,1
addi x20 x0 48 #prints h2 = 0
sb x20, 0xA0(x21)
loop:lb x9,0xA4(x21)
bne x9,x1,loop
again: lb x9,0xA4(x21) 
bne x9,x0,again


addi x12 x0 48 #prints h1 = 0
sb x12, 0xA0(x21)
loop1:lb x9,0xA4(x21)
bne x9,x1,loop1
again1: lb x9,0xA4(x21) 
bne x9,x0,again1


addi x10 x0 58 #prints ":"
sb x10, 0xA0(x21)
loop2:lb x9,0xA4(x21)
bne x9,x1,loop2
again2: lb x9,0xA4(x21) 
bne x9,x0,again2


addi x5 x0 48 #prints m2 = 0
sb x5, 0xA0(x21)
loop_mint:lb x9,0xA4(x21)
bne x9,x1,loop_mint
again3: lb x9,0xA4(x21) 
bne x9,x0,again3

addi x6 x0 48 #prints m1 = 0
sb x6, 0xA0(x21)
loop_mint1:lb x9,0xA4(x21)
bne x9,x1,loop_mint1
again4: lb x9,0xA4(x21) 
bne x9,x0,again4

sb x10, 0xA0(x21) #prints ":"
loop_wait:lb x9,0xA4(x21)
bne x9,x1,loop_wait
again5: lb x9,0xA4(x21) 
bne x9,x0,again5

addi x7 x0 48 #prints s2 = 0
sb x7, 0xA0(x21)
loop_sec:lb x9,0xA4(x21)
bne x9,x1,loop_sec
again6: lb x9,0xA4(x21) 
bne x9,x0,again6

addi x8 x0 49 #prints s1 = 1
sb x8, 0xA0(x21)
loop_sec1:lb x9,0xA4(x21)
bne x9,x1,loop_sec1
again7: lb x9,0xA4(x21) 
bne x9,x0,again7
