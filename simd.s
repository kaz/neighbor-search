//+build !noasm !appengine
// AUTO-GENERATED BY C2GOASM -- DO NOT EDIT

TEXT ·__lookup_popcnt(SB), $0-40

    MOVQ haystack+0(FP), DI
    MOVQ haystackLen+8(FP), SI
    MOVQ needle+16(FP), DX
    MOVQ tolerance+24(FP), CX
    MOVQ result+32(FP), R8

    LONG $0x0000c741; WORD $0x0000; BYTE $0x00 // mov    dword [r8], 0
    WORD $0xf685                 // test    esi, esi
	JE LBB0_5
    WORD $0x634c; BYTE $0xce     // movsxd    r9, esi
    WORD $0x634c; BYTE $0xd1     // movsxd    r10, ecx
    WORD $0xf631                 // xor    esi, esi
    WORD $0xc031                 // xor    eax, eax
	JMP LBB0_2
LBB0_4:
    WORD $0xff48; BYTE $0xc0     // inc    rax
    WORD $0x394c; BYTE $0xc8     // cmp    rax, r9
	JAE LBB0_5
LBB0_2:
    LONG $0xc70c8b48             // mov    rcx, qword [rdi + 8*rax]
    WORD $0x3148; BYTE $0xd1     // xor    rcx, rdx
    LONG $0xb80f48f3; BYTE $0xc9 // popcnt    rcx, rcx
    WORD $0x394c; BYTE $0xd1     // cmp    rcx, r10
	JG LBB0_4
    WORD $0xc6ff                 // inc    esi
    WORD $0x8941; BYTE $0x30     // mov    dword [r8], esi
	JMP LBB0_4
LBB0_5:
    RET




DATA LCDATA1<>+0x000(SB)/8, $0x0f0f0f0f0f0f0f0f
DATA LCDATA1<>+0x008(SB)/8, $0x0f0f0f0f0f0f0f0f
DATA LCDATA1<>+0x010(SB)/8, $0x0f0f0f0f0f0f0f0f
DATA LCDATA1<>+0x018(SB)/8, $0x0f0f0f0f0f0f0f0f
DATA LCDATA1<>+0x020(SB)/8, $0x0302020102010100
DATA LCDATA1<>+0x028(SB)/8, $0x0403030203020201
DATA LCDATA1<>+0x030(SB)/8, $0x0302020102010100
DATA LCDATA1<>+0x038(SB)/8, $0x0403030203020201
GLOBL LCDATA1<>(SB), 8, $64

TEXT ·__lookup_simd(SB), $0-40

    MOVQ haystack+0(FP), DI
    MOVQ haystackLen+8(FP), SI
    MOVQ needle+16(FP), DX
    MOVQ tolerance+24(FP), CX
    MOVQ result+32(FP), R8
    LEAQ LCDATA1<>(SB), BP

    LONG $0x0000c741; WORD $0x0000; BYTE $0x00 // mov    dword [r8], 0
    WORD $0xf685                 // test    esi, esi
	JE LBB1_4
    LONG $0x6ef9e1c4; BYTE $0xc2 // vmovq    xmm0, rdx
    LONG $0x597de2c4; BYTE $0xc0 // vpbroadcastq    ymm0, xmm0
    WORD $0x6348; BYTE $0xc6     // movsxd    rax, esi
    WORD $0xc1ff                 // inc    ecx
    WORD $0x6348; BYTE $0xc9     // movsxd    rcx, ecx
    LONG $0x6ef9e1c4; BYTE $0xc9 // vmovq    xmm1, rcx
    LONG $0x597de2c4; BYTE $0xc9 // vpbroadcastq    ymm1, xmm1
    WORD $0xc931                 // xor    ecx, ecx
    LONG $0x556ffdc5; BYTE $0x00 // vmovdqa    ymm2, yword 0[rbp] /* [rip + LCPI1_0] */
    LONG $0x5d6ffdc5; BYTE $0x20 // vmovdqa    ymm3, yword 32[rbp] /* [rip + LCPI1_1] */
    LONG $0xe4efd9c5             // vpxor    xmm4, xmm4, xmm4
    WORD $0xd231                 // xor    edx, edx
LBB1_2:
    LONG $0x2ceffdc5; BYTE $0xd7 // vpxor    ymm5, ymm0, yword [rdi + 8*rdx]
    LONG $0xd571cdc5; BYTE $0x04 // vpsrlw    ymm6, ymm5, 4
    LONG $0xeadbd5c5             // vpand    ymm5, ymm5, ymm2
    LONG $0x0065e2c4; BYTE $0xed // vpshufb    ymm5, ymm3, ymm5
    LONG $0xf2dbcdc5             // vpand    ymm6, ymm6, ymm2
    LONG $0x0065e2c4; BYTE $0xf6 // vpshufb    ymm6, ymm3, ymm6
    LONG $0xedfccdc5             // vpaddb    ymm5, ymm6, ymm5
    LONG $0xecf6d5c5             // vpsadbw    ymm5, ymm5, ymm4
    LONG $0xed64f5c5             // vpcmpgtb    ymm5, ymm1, ymm5
    LONG $0xf5d7fdc5             // vpmovmskb    esi, ymm5
    LONG $0xb80f48f3; BYTE $0xf6 // popcnt    rsi, rsi
    WORD $0xf101                 // add    ecx, esi
    LONG $0x04c28348             // add    rdx, 4
    WORD $0x3948; BYTE $0xc2     // cmp    rdx, rax
	JB LBB1_2
    WORD $0x8941; BYTE $0x08     // mov    dword [r8], ecx
LBB1_4:
    VZEROUPPER
    RET
