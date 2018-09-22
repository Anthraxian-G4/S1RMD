		jsr	ClearPLC
		jsr	Pal_FadeFrom
		jsr	ClearScreen
		moveq	#3,d0
		jsr	PalLoad1
		move.l	#$59400003,($C00004).l
		lea	(Nem_Hud).l,a0
		jsr	NemDec
		bsr	ClrObjRAM

.ScrBonArt:
		;LoadUncArt	Art_RslsBG,$40200000,$FF

.ScrBonPal:
		;LoadPal	Pal_RslsBG,RAM_Pal2_2prc,15

.ScrBonMap:
		;LoadUncMap	Map_RslsBG,$10,$1+Pal_2,320,224,PlaneB_Waddr,0,0

		jsr	GotThroughAct
		jsr	Pal_FadeTo

.ScrBonMainLoop:
		move.b	#8,($FFFFF62A).w
		jsr	DelayProgram
		jsr	RunPLC_RAM
		jsr	ObjectsLoad
		jsr	BuildSprites
		cmp.b	#$24,($FFFFF600).w
		beq	.ScrBonMainLoop
		rts

ClrObjRAM:
		moveq	#0,d0
		move.w	#$7FF,d1
	@lp1:	move.l	d0,(a1)+
		dbf	d1,@lp1
		rts
