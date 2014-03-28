" Vim syntax file
" Language:	GDScript
" Maintainer:	quabug <quabug@gmail.com>
" Last Change:	2014 Feb 26

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" We need nocompatible mode in order to continue lines with backslashes.
" Original setting will be restored.
let s:cpo_save = &cpo
set cpo&vim
"
syn keyword gdscriptStatement	false, null, true
syn keyword gdscriptStatement	assert break continue tool
syn keyword gdscriptStatement	pass print return
syn keyword gdscriptStatement	class func nextgroup=gdscriptFunction skipwhite
syn keyword gdscriptConditional	elif else if
syn keyword gdscriptRepeat	for while
syn keyword gdscriptOperator	and in not or extends
syn match gdscriptInclude	"^extends"
syn keyword gdscriptStorage	export
syn keyword gdscriptType	var const int float bool String
syn keyword gdscriptStructure	enum

syn match   gdscriptDecorator	"@" display nextgroup=gdscriptFunction skipwhite
" The zero-length non-grouping match before the function name is
" extremely important in gdscriptFunction.  Without it, everything is
" interpreted as a function inside the contained environment of
" doctests.
" A dot must be allowed because of @MyClass.myfunc decorators.
syn match   gdscriptFunction
      \ "\%(\%(func\s\|class\s\|@\)\s*\)\@<=\h\%(\w\|\.\)*" contained

syn match   gdscriptComment	"#.*$" contains=gdscriptTodo,@Spell
syn keyword gdscriptTodo		FIXME NOTE NOTES TODO XXX HACK contained

" Triple-quoted strings can contain doctests.
syn region  gdscriptString
      \ start=+[uU]\=\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=gdscriptEscape,@Spell
syn region  gdscriptRawString
      \ start=+[uU]\=[rR]\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=@Spell

syn match   gdscriptEscape	+\\[abfnrtv'"\\]+ contained
syn match   gdscriptEscape	"\\\o\{1,3}" contained
syn match   gdscriptEscape	"\\x\x\{2}" contained
syn match   gdscriptEscape	"\%(\\u\x\{4}\|\\U\x\{8}\)" contained
" gdscript allows case-insensitive Unicode IDs: http://www.unicode.org/charts/
syn match   gdscriptEscape	"\\N{\a\+\%(\s\a\+\)*}" contained
syn match   gdscriptEscape	"\\$"

"if exists("gdscript_highlight_all")
  "if exists("gdscript_no_builtin_highlight")
    "unlet gdscript_no_builtin_highlight
  "endif
  "if exists("gdscript_no_doctest_code_highlight")
    "unlet gdscript_no_doctest_code_highlight
  "endif
  "if exists("gdscript_no_doctest_highlight")
    "unlet gdscript_no_doctest_highlight
  "endif
  "if exists("gdscript_no_exception_highlight")
    "unlet gdscript_no_exception_highlight
  "endif
  "if exists("gdscript_no_number_highlight")
    "unlet gdscript_no_number_highlight
  "endif
  "let gdscript_space_error_highlight = 1
"endif
"if !exists("gdscript_no_number_highlight")
  " numbers (including longs and complex)
  syn match   gdscriptNumber	"\<0[oO]\=\o\+[Ll]\=\>"
  syn match   gdscriptNumber	"\<0[xX]\x\+[Ll]\=\>"
  syn match   gdscriptNumber	"\<0[bB][01]\+[Ll]\=\>"
  syn match   gdscriptNumber	"\<\%([1-9]\d*\|0\)[Ll]\=\>"
  syn match   gdscriptNumber	"\<\d\+[jJ]\>"
  syn match   gdscriptNumber	"\<\d\+[eE][+-]\=\d\+[jJ]\=\>"
  syn match   gdscriptNumber
	\ "\<\d\+\.\%([eE][+-]\=\d\+\)\=[jJ]\=\%(\W\|$\)\@="
  syn match   gdscriptNumber
	\ "\%(^\|\W\)\@<=\d*\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>"
"endif

" Group the built-ins in the order in the 'gdscript Library Reference' for
" easier comparison.
" http://docs.gdscript.org/library/constants.html
" http://docs.gdscript.org/library/functions.html
" http://docs.gdscript.org/library/functions.html#non-essential-built-in-functions
" gdscript built-in functions are in alphabetical order.
"if !exists("gdscript_no_builtin_highlight")
  "" built-in constants
  "" 'False', 'True', and 'None' are also reserved words in gdscript 3.0
  "syn keyword gdscriptBuiltin	False True None
  "syn keyword gdscriptBuiltin	NotImplemented Ellipsis __debug__
  "" built-in functions
  "syn keyword gdscriptBuiltin	abs all any bin bool chr classmethod
  "syn keyword gdscriptBuiltin	compile complex delattr dict dir divmod
  "syn keyword gdscriptBuiltin	enumerate eval filter float format
  "syn keyword gdscriptBuiltin	frozenset getattr globals hasattr hash
  "syn keyword gdscriptBuiltin	help hex id input int isinstance
  "syn keyword gdscriptBuiltin	issubclass iter len list locals map max
  "syn keyword gdscriptBuiltin	min next object oct open ord pow print
  "syn keyword gdscriptBuiltin	property range repr reversed round set
  "syn keyword gdscriptBuiltin	setattr slice sorted staticmethod str
  "syn keyword gdscriptBuiltin	sum super tuple type vars zip __import__
  "" gdscript 2.6 only
  "syn keyword gdscriptBuiltin	basestring callable cmp execfile file
  "syn keyword gdscriptBuiltin	long raw_input reduce reload unichr
  "syn keyword gdscriptBuiltin	unicode xrange
  "" gdscript 3.0 only
  "syn keyword gdscriptBuiltin	ascii bytearray bytes exec memoryview
  "" non-essential built-in functions; gdscript 2.6 only
  "syn keyword gdscriptBuiltin	apply buffer coerce intern
"endif

" From the 'gdscript Library Reference' class hierarchy at the bottom.
" http://docs.gdscript.org/library/exceptions.html
"if !exists("gdscript_no_exception_highlight")
  "" builtin base exceptions (only used as base classes for other exceptions)
  "syn keyword gdscriptExceptions	BaseException Exception
  "syn keyword gdscriptExceptions	ArithmeticError EnvironmentError
  "syn keyword gdscriptExceptions	LookupError
  "" builtin base exception removed in gdscript 3.0
  "syn keyword gdscriptExceptions	StandardError
  "" builtin exceptions (actually raised)
  "syn keyword gdscriptExceptions	AssertionError AttributeError BufferError
  "syn keyword gdscriptExceptions	EOFError FloatingPointError GeneratorExit
  "syn keyword gdscriptExceptions	IOError ImportError IndentationError
  "syn keyword gdscriptExceptions	IndexError KeyError KeyboardInterrupt
  "syn keyword gdscriptExceptions	MemoryError NameError NotImplementedError
  "syn keyword gdscriptExceptions	OSError OverflowError ReferenceError
  "syn keyword gdscriptExceptions	RuntimeError StopIteration SyntaxError
  "syn keyword gdscriptExceptions	SystemError SystemExit TabError TypeError
  "syn keyword gdscriptExceptions	UnboundLocalError UnicodeError
  "syn keyword gdscriptExceptions	UnicodeDecodeError UnicodeEncodeError
  "syn keyword gdscriptExceptions	UnicodeTranslateError ValueError VMSError
  "syn keyword gdscriptExceptions	WindowsError ZeroDivisionError
  "" builtin warnings
  "syn keyword gdscriptExceptions	BytesWarning DeprecationWarning FutureWarning
  "syn keyword gdscriptExceptions	ImportWarning PendingDeprecationWarning
  "syn keyword gdscriptExceptions	RuntimeWarning SyntaxWarning UnicodeWarning
  "syn keyword gdscriptExceptions	UserWarning Warning
"endif

"if exists("gdscript_space_error_highlight")
  " trailing whitespace
  syn match   gdscriptSpaceError	display excludenl "\s\+$"
  " mixed tabs and spaces
  syn match   gdscriptSpaceError	display " \+\t"
  syn match   gdscriptSpaceError	display "\t\+ "
"endif

" Do not spell doctests inside strings.
" Notice that the end of a string, either ''', or """, will end the contained
" doctest too.  Thus, we do *not* need to have it as an end pattern.
"if !exists("gdscript_no_doctest_highlight")
  "if !exists("gdscript_no_doctest_code_highlight")
    "syn region gdscriptDoctest
	  "\ start="^\s*>>>\s" end="^\s*$"
	  "\ contained contains=ALLBUT,gdscriptDoctest,@Spell
    "syn region gdscriptDoctestValue
	  "\ start=+^\s*\%(>>>\s\|\.\.\.\s\|"""\|'''\)\@!\S\++ end="$"
	  "\ contained
  "else
    "syn region gdscriptDoctest
	  "\ start="^\s*>>>" end="^\s*$"
	  "\ contained contains=@NoSpell
  "endif
"endif

" Sync at the beginning of class, function, or method definition.
syn sync match gdscriptSync grouphere NONE "^\s*\%(func\|class\)\s\+\h\w*\s*("

if version >= 508 || !exists("did_gdscript_syn_inits")
  if version <= 508
    let did_gdscript_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default highlight links.  Can be overridden later.
  HiLink gdscriptStatement	Statement
  HiLink gdscriptConditional	Conditional
  HiLink gdscriptRepeat		Repeat
  HiLink gdscriptOperator	Operator
  "HiLink gdscriptException	Exception
  HiLink gdscriptInclude	Include
  HiLink gdscriptDecorator	Define
  HiLink gdscriptFunction	Function
  HiLink gdscriptComment	Comment
  HiLink gdscriptTodo		Todo
  HiLink gdscriptString		String
  HiLink gdscriptRawString	String
  HiLink gdscriptEscape		Special
  HiLink gdscriptStorage	StorageClass
  HiLink gdscriptType		Type
  HiLink gdscriptStructure	Structure
  "if !exists("gdscript_no_number_highlight")
    HiLink gdscriptNumber	Number
  "endif
  "if !exists("gdscript_no_builtin_highlight")
    HiLink gdscriptBuiltin	Function
  "endif
  "if !exists("gdscript_no_exception_highlight")
    "HiLink gdscriptExceptions	Structure
  "endif
  "if exists("gdscript_space_error_highlight")
    HiLink gdscriptSpaceError	Error
  "endif
  "if !exists("gdscript_no_doctest_highlight")
    "HiLink gdscriptDoctest	Special
    "HiLink gdscriptDoctestValue	Define
  "endif

  delcommand HiLink
endif

let b:current_syntax = "gdscript"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set sw=2 sts=2 ts=8 noet:
