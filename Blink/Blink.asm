;
; Blink.asm
;
; Created: 2020-01-15
; Author : Eric Grevillius
;

;==============================================================================
; Definitions of registers, etc. ("constants")
;==============================================================================
	.EQU			RESET		 =	0x0000			; reset vector
	.EQU			PM_START	 =	0x0072			; start of program
	.DEF			TEMP		 =	R16

;==============================================================================
; Start of program
;==============================================================================
	.CSEG
	.ORG			RESET
	RJMP			init

	.ORG			PM_START
	.INCLUDE		"delay.inc"
	
;==============================================================================
; Basic initializations of stack pointer, etc.
;==============================================================================
init:
	LDI				TEMP,			LOW(RAMEND)		; Set stack pointer
	OUT				SPL,			TEMP			; at the end of RAM.
	LDI				TEMP,			HIGH(RAMEND)
	OUT				SPH,			TEMP
	RCALL			init_pins						; Initialize pins
	RJMP			main							; Jump to main

;==============================================================================
; Initialise I/O pins
;==============================================================================
init_pins:

	SBI		DDRB,	5		; set on-board LED to output
	RET

main:
	SBI		PORTB,	5
	RCALL	delay_1_s
	CBI		PORTB,	5
	RCALL	delay_1_s


