" VIM Syntax File
" Language:	ICL/Fujitsu TP Stats analysis control language
" Maintainer:	Andy Long (Andrew.Long@Yahoo.com)
" LastChange:	$Date$
" Version:	$Revision$
" Remarks:	TPMS is the Transaction Processing system for VME mainframe
"		systems. TPSTATS/tpstats are the utilities that prints input
"		and output messages and performance statisticsfrom the Audit
"		Trail
"
" $Log: tpstats.vim,v $
"
"
if version<600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

syntax	case	ignore

syntax	match	tpstatsError
	\	/\S*/
syntax	match	tpstatsError
	\	/\k\+/

syntax	match	tpstatsAmpersand	contained
	\	/&/

syntax	match	tpstatsComma	contained
	\	/,/

syntax	match	tpstatsEquals	contained
	\	/=/

syntax	match	tpstatsSemiColon	contained
	\	/;/

syntax	match	tpstatsConstant	contained
	\	/\S*/

syntax	match	tpstatsFileName
	\	/[\*:]\=[A-Za-z]\=\S*/

syntax	match	tpstatsNumber	contained
	\	/\<\d\+\>/

syntax	match	tpstatsPageNumber	contained skipwhite nextgroup=tpstatsNumber,tpstatsError
	\	/\<page\>\s*/

syntax	match	tpstatsRunDate	contained skipwhite nextgroup=tpstatsDateAndTime,tpstatsError
	\	/\<run:\s*/

syntax	match	tpstatsDateAndTime	contained contains=tpstatsDate,tpstatsTime
	\	/\<\d\+\/\d\+\/\d\+\>\s\+\<\d\d:\d\d:\d\d\>/

syntax	match	tpstatsDate	contained skipwhite nextgroup=tpstatsTime
	\	/\<\d\+\/\d\+\/\d\+\>/

syntax	match	tpstatsTime	contained
	\	/\<\d\d:\d\d:\d\d/

syntax	match	tpstatsGraphNa	contained skipwhite nextgroup=tpstatsGraphName
	\	/\<graph_name:/
syntax	match	tpstatsAvmName	contained
	\	/\<\a\k\{0,11}\>/

syntax	match	tpstatsAvmName	contained
	\	/\*\*\* system reply \*\*\*/

syntax	match	tpstatsTermName	contained
	\	/\<\a\k\{0,11}\>/

syntax	match	tpstatsStatement	skipwhite nextgroup=tpstatsTime,tpstatsError
	\	/^iptime :\s*/

syntax	match	tpstatsStatement	skipwhite nextgroup=tpstatsConstant
	\	/^iptext :\s*/

syntax	match	tpstatsStatement	skipwhite nextgroup=tpstatsConstant
	\	/^optext :\s*/

syntax	match	tpstatsStatement	skipwhite nextgroup=tpstatsTermName,tpstatsError
	\	/\<Term :\s*/

syntax	match	tpstatsStatement	skipwhite nextgroup=tpstatsAvmName,tpstatsError
	\	/\<avm :\s*/

syntax	match	tpstatsStatement	skipwhite nextgroup=tpstatsAvmName,tpstatsError
	\	/\<dest :\s*/

syntax	match	tpstatsAnalysisStart	contained skipwhite nextgroup=tpstatsDateAndTime,tpstatsError
	\	/\<start:\s*/

syntax	match	tpstatsAnalysisEnd	contained skipwhite nextgroup=tpstatsDateAndTime,tpstatsError
	\	/\<end:\s*/

syntax	match	tpstatsStatement
	\	/^final reply\>/

syntax	match	tpstatsStatement
	\	/^unsolicited reply\>/

syntax	match	tpstatsComment
	\	/^end time or end of file or session start found$/

syntax	match	tpstatsComment
	\	/^any requested unterminated messages now printed$/

syntax	region	tpstatsComment keepend
	\	contains=tpstatsRunDate,tpstatsPageNumber,tpstatsStatement
	\	matchgroup=tpstatsComment
	\	start=/\<tpst analysis parameters\>/ 
	\	end=/^end of command file processing\>/

syntax	region	tpstatsComment keepend
	\	matchgroup=tpstatsComment
	\	start=/\<audit file processing now starts\>/ 
	\	end=/\<end of audit file processing\>/

syntax	region	tpstatsComment keepend	skipwhite nextgroup=tpstatsFileName
	\	contains=tpstatsAnalysisStart,tpstatsAnalysisEnd,tpstatsRunDate, tpstatsPageNumber
	\	matchgroup=tpstatsComment 
	\	start=/\<tpstats analysis list of message texts/ 
	\	end=/^\s\+audit file:\s*/ 
"

syntax	region	tpstatsComment keepend	skipwhite nextgroup=tpstatsFileName
	\	contains=tpstatsXAxisValues,tpstatsYAxisValues,tpstatsGraphNa,tpstatsAnalysisStart,tpstatsAnalysisEnd,tpstatsRunDate,tpstatsPageNumber
	\	matchgroup=tpstatsComment 
	\	start=/\<tpst analysis graph of/ 
	\	end=/^\s\+audit file:\s*/ 
"
"	This is a list of parameter values for the TP Stats commands
"
syntax	match	tpstatsChar	contained
	\	/\<\S\>/

syntax	match	tpstatsGraphName	contained
	\	/\<\a\k\{2,7\}\>/

syntax	match	tpstatsAvmName	contained
	\	/\<TPA\d\d\a\k*\>/

syntax	match	tpstatsAvmTypeName	contained
	\	/\<\a\k\{2,11\}\>/

syntax	match	tpstatsMsgName	contained
	\	/\<\k\{1,12\}\>/

syntax	match	tpstatsTermType	contained
	\	/[RST]/

syntax	match	tpstatsTermName	contained
	\	/\<\a\k\{2,11\}\>/

syntax	match	tpstatsTxnId	contained
	\	/\<\k\{4}\>/
"
"	This is the complete list of reserved words
"
"	These are the commands recognised by TPStats
"
syntax	match	tpstatsReservedWords	contained
	\	/\<\(GRAPH\|HELP\|LIST\|OMIT\|PERFORM\|RECLIST\|SELECT\|TEXTLIST\|UNREC\|VALIDATE\)\>/
"
"	These are Parameter keywords and enumerated values
"
syntax	match	tpstatsXAxisValues	contained
	\	/\<IPTIME\>/

syntax	match	tpstatsYAxisValues	contained
	\	/\<\(OCP\|MCT\|VSI\|IO\|MS\|QTIME\|RTIME\)\>/

syntax	match	tpstatsReservedWords	contained
	\	/\<\(XAXIS\|YMIN\|YMAX\|YAXIS\|GRAPHNA\|AVMNFULL\|AVMNA\|MAFUNC\|MSGNA\|TERMNA\|TRANID\|TTYPE\|RTYPE\|INPUT\|OUTPUT\|CHAR\)\>/
"
"	This is the list of parameters for the TP Stats commands
"
syntax	region	tpstatsAvmFull	fold keepend contained contains=tpstatsEquals,tpstatsAvmName,tpstatsAmpersand,tpstatsError
	\	matchgroup=tpstatsReservedWords
	\	start=/\<AVMFULL\>\s*=/me=s+6
	\	matchgroup=tpstatsComma
	\	end=/,/

syntax	region	tpstatsAvmNa	fold keepend contained contains=tpstatsEquals,tpstatsAvmTypeName,tpstatsAmpersand,tpstatsError
	\	matchgroup=tpstatsReservedWords
	\	start=/\<AVMNA\>\s*=/me=s+4
	\	matchgroup=tpstatsComma
	\	end=/,/

syntax	region	tpstatsGraphNa	fold keepend contained contains=tpstatsEquals,tpstatsGraphName,tpstatsAmpersand,tpstatsError
	\	matchgroup=tpstatsReservedWords
	\	start=/\<GRAPHNA\>\s*=/me=s+5
	\	matchgroup=tpstatsComma
	\	end=/,/

syntax	region	tpstatsInput	fold keepend contained contains=tpstatsEquals,tpstatsNumber,tpstatsError
	\	matchgroup=tpstatsReservedWords
	\	start=/\<INPUT\>\s*=/me=s+4
	\	matchgroup=tpstatsComma
	\	end=/,/

syntax	region	tpstatsIPTime	fold keepend contained contains=tpstatsEquals,tpstatsTime,tpstatsAmpersand,tpstatsError
	\	matchgroup=tpstatsReservedWords
	\	start=/\<IPTIME\>\s*=/me=s+5
	\	matchgroup=tpstatsComma
	\	end=/,/

syntax	region	tpstatsMAFunc	fold keepend contained contains=tpstatsEquals,tpstatsNumber,tpstatsAmpersand,tpstatsError
	\	matchgroup=tpstatsReservedWords
	\	start=/\<MAFUNC\>\s*=/me=s+5
	\	matchgroup=tpstatsComma
	\	end=/,/

syntax	region	tpstatsMsgNa	fold keepend contained contains=tpstatsEquals,tpstatsMsgName,tpstatsAmpersand,tpstatsError
	\	matchgroup=tpstatsReservedWords
	\	start=/\<MSGNA\>\s*=/me=s+4
	\	matchgroup=tpstatsComma
	\	end=/,/

syntax	region	tpstatsRtype	fold keepend contained contains=tpstatsEquals,tpstatsNumber,tpstatsError
	\	matchgroup=tpstatsReservedWords
	\	start=/\<RTYPE\>\s*=/me=s+5
	\	matchgroup=tpstatsComma
	\	end=/,/

syntax	region	tpstatsTermNa	fold keepend contained contains=tpstatsEquals,tpstatsTermName,tpstatsAmpersand,tpstatsError
	\	matchgroup=tpstatsReservedWords
	\	start=/\<TERMNA\>\s*=/me=s+5
	\	matchgroup=tpstatsComma
	\	end=/,/

syntax	region	tpstatsTranId	fold keepend contained contains=tpstatsEquals,tpstatsTxnId,tpstatsAmpersand,tpstatsError
	\	matchgroup=tpstatsReservedWords
	\	start=/\<TRANID\>\s*=/me=s+5
	\	matchgroup=tpstatsComma
	\	end=/,/

syntax	region	tpstatsTType	fold keepend contained contains=tpstatsEquals,tpstatsTermType,tpstatsAmpersand,tpstatsError
	\	matchgroup=tpstatsReservedWords
	\	start=/\<TTYPE\>\s*=/me=s+4
	\	matchgroup=tpstatsComma
	\	end=/,/

syntax	region	tpstatsXAxis	fold keepend contained contains=tpstatsEquals,tpstatsXAxisValues,tpstatsError
	\	matchgroup=tpstatsReservedWords
	\	start=/\<XAXIS\>\s*=/me=s+4
	\	matchgroup=tpstatsComma
	\	end=/,/

syntax	region	tpstatsYAxis	fold keepend contained contains=tpstatsEquals,tpstatsYAxisValues,tpstatsError
	\	matchgroup=tpstatsReservedWords
	\	start=/\<YAXIS\>\s*=/me=s+4
	\	matchgroup=tpstatsComma
	\	end=/,/

syntax	region	tpstatsYMax	fold keepend contained contains=tpstatsEquals,tpstatsNumber,tpstatsError
	\	matchgroup=tpstatsReservedWords
	\	start=/\<YMAX\>\s*=/
	\	matchgroup=tpstatsComma
	\	end=/,/

syntax	region	tpstatsYMin	fold keepend contained contains=tpstatsEquals,tpstatsNumber,tpstatsError
	\	matchgroup=tpstatsReservedWords
	\	start=/\<YMIN\>\s*=/me=s+3
	\	matchgroup=tpstatsComma
	\	end=/,/
"
"	This is the list of TP Stats Command
"
syntax	keyword	tpstatsStatement	HELP LIST PERFORM VALIDATE

syntax	region	tpstatsStatement	fold keepend contained contains=tpstatsXAxis,tpstatsYAxis,tpstatsYMin,tpstatsYMax,tpstatsGraphNa
	\	matchgroup=tpstatsReservedWords
	\	start=/\<GRAPH\>/ 
	\	matchgroup=tpstatsSemiColon
	\	end=/;/
	\	matchgroup=tpstatsReservedWords
	\	end=/\<VALIDATE\>/

syntax	region	tpstatsStatement	fold keepend extend contained contains=tpstatsAvmFull,tpstatsAvmNa,tpstatsGraphNa,tpstatsIPTime,
	\	tpstatsMaFunc,tpstatsMsgNa,tpstatsTermNa,tpstatsTranId,tpstatsTType,tpstatsError
	\	matchgroup=tpstatsReservedWords
	\	start=/\<OMIT\>/
	\	matchgroup=tpstatsSemiColon
	\	end=/;/
	\	matchgroup=tpstatsReservedWords
	\	end=/\<VALIDATE\>/

syntax	region	tpstatsStatement	fold keepend extend contained contains=tpstatsRtpe,tpstatsError
	\	start=/\<RECLIST\>/
	\	matchgroup=tpstatsSemiColon
	\	end=/;/
	\	matchgroup=tpstatsReservedWords
	\	end=/\<VALIDATE\>/

syntax	region	tpstatsStatement	fold keepend extend contained contains=tpstatsAvmFull,tpstatsAvmNa,tpstatsGraphNa,tpstatsIPTime,
	\	tpstatsMaFunc,tpstatsMsgNa,tpstatsTermNa,tpstatsTranId,tpstatsTType,tpstatsError
	\	matchgroup=tpstatsReservedWords
	\	start=/\<SELECT\>/
	\	matchgroup=tpstatsSemiColon
	\	end=/;/
	\	matchgroup=tpstatsReservedWords
	\	end=/\<VALIDATE\>/

syntax	region	tpstatsStatement	fold keepend extend contained contains=tpstatsInput,tpstatsOutput,tpstatsChar,tpstatsError
	\	matchgroup=tpstatsReservedWords
	\	start=/\<TEXTLIST\>/
	\	matchgroup=tpstatsSemiColon
	\	end=/;/
	\	matchgroup=tpstatsReservedWords
	\	end=/\<VALIDATE\>/

syntax	region	tpstatsStatement	fold keepend extend contained contains=tpstatsTermNa,tpstatsError
	\	matchgroup=tpstatsReservedWords
	\	start=/\<UNREC\>/
	\	matchgroup=tpstatsSemiColon
	\	end=/;/
	\	matchgroup=tpstatsReservedWords
	\	end=/\<VALIDATE\>/

syntax	sync	fromstart

if version >= 508 || !exists("did_c_syn_inits")
	if version < 508
		let did_c_syn_inits = 1
		command -nargs=+ HiLink hi link <args>
	else
		command -nargs=+ HiLink hi def link <args>
	endif

	HiLink	tpstatsIdentifier	Identifier

	HiLink	tpstatsNumber		Number
	HiLink	tpstatsHexNumber	Number
	HiLink	tpstatsOneHour		Number

	HiLink	tpstatsComment		Comment

	HiLink	tpstatsConstant		Constant
	HiLink	tpstatsFileName		Constant
	HiLink	tpstatsDateAndTime	Constant
	HiLink	tpstatsDate		Constant
	HiLink	tpstatsTime		Constant
	HiLink	tpstatsAvmName		Constant
	HiLink	tpstatsAvmTypeName	Constant
	HiLink	tpstatsGraphName	Constant
	HiLink	tpstatsMsgName		Constant
	HiLink	tpstatsTermName		Constant
	HiLink	tpstatsTermType		Constant

	HiLink	tpstatsStringConst	String

	HiLink	tpstatsStatement	Statement
	HiLink	tpstatsAnalysisStart	Statement
	HiLink	tpstatsAnalysisEnd	Statement
	HiLink	tpstatsPageNumber	Statement
	HiLink	tpstatsRunDate		Statement
	HiLink	tpstatsXAxisValues	Statement
	HiLink	tpstatsYAxisValues	Statement

	HiLink	tpstatsReservedWords	Statement

	HiLink	tpstatsSpecial		Special
	HiLink	tpstatsSpecialChar	SpecialChar
	HiLink	tpstatsStringEsc	Special
	HiLink	tpstatsStringEsc	Special
	HiLink	tpstatsTag		Tag
	HiLink	tpstatsAmpersand	Delimiter
	HiLink	tpstatsComma		Delimiter
	HiLink	tpstatsEquals		Delimiter
	HiLink	tpstatsSemiColon	Delimiter
	HiLink	tpstatsEquals		Delimiter
	HiLink	tpstatsAmpersand	Delimiter
	HiLink	tpstatsSpecialComment	SpecialComment
	HiLink	tpstatsDebug		Debug

	HiLink	tpstatsUnderlined	Underlined

	HiLink	tpstatsIgnore		Ignore

	HiLink	tpstatsError		Error

	HiLink	tpstatsTodo		Todo

	delcommand HiLink
endif

let b:current_syntax = "tpstats"

