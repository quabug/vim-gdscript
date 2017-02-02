" Vim syntax file
" Language:	GDScript
" Maintainer:	quabug <quabug@gmail.com>
" Contributor:  Hilton Medeiros <https://github.com/hiltonm>
" Contributor:  Ludvig Böklin <https://github.com/lboklin>
" Last Change:	2016 January 29

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
syn keyword gdscriptStatement	false null true
syn keyword gdscriptStatement	assert break continue tool breakpoint
syn keyword gdscriptStatement	pass self return
syn keyword gdscriptStatement	remote sync master slave nextgroup=gdscriptStatement skipwhite
syn keyword gdscriptStatement	class func nextgroup=gdscriptFunction skipwhite
syn keyword gdscriptConditional	elif else if
syn keyword gdscriptRepeat	for while
syn keyword gdscriptOperator	and in not or extends
syn match gdscriptInclude	"^extends"
syn keyword gdscriptStorage	export
syn keyword gdscriptType	var const int real bool String
syn keyword gdscriptStructure	enum

syn keyword gdscriptType        Vector2 Size2 Rect2 Vector3 Matrix32 Plane
syn keyword gdscriptType        Quat AABB Box3 Matrix3 Transform
syn keyword gdscriptType        Color Image NodePath RID Object InputEvent
syn keyword gdscriptType        RawArray IntArray FloatArray StringArray
syn keyword gdscriptType        Vector2Array Vector3Array ColorArray
syn keyword gdscriptType        Nil Dictionary Array

syn keyword gdscriptBuiltin     sin cos tan sinh cosh tanh asin acos atan atan2
syn keyword gdscriptBuiltin     sqrt fmod fposmod floor ceil round abs sign pow
syn keyword gdscriptBuiltin     log exp isnan isinf ease decimals stepify lerp
syn keyword gdscriptBuiltin     dectime randomize randi randf rand_range rand_seed
syn keyword gdscriptBuiltin     deg2rad rad2deg linear2db db2linear max min clamp
syn keyword gdscriptBuiltin     nearest_po2 weakref funcref convert str print
syn keyword gdscriptBuiltin     printt printerr printraw range load inst2dict
syn keyword gdscriptBuiltin     dict2inst preload print_stack onready

syn match   gdscriptDecorator	"@" display nextgroup=gdscriptFunction skipwhite
" The zero-length non-grouping match before the function name is
" extremely important in gdscriptFunction.  Without it, everything is
" interpreted as a function inside the contained environment of
" doctests.
" A dot must be allowed because of @MyClass.myfunc decorators.
syn match   gdscriptFunction /\k\+\%(\s*(\)\@=/ 

syn match   gdscriptComment	"#.*$" contains=gdscriptTodo,@Spell
syn keyword gdscriptTodo		FIXME NOTE NOTES TODO XXX HACK contained

setlocal commentstring=#%s

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

"if exists("gdscript_space_error_highlight")
  " trailing whitespace
  syn match   gdscriptSpaceError	display excludenl "\s\+$"
  " mixed tabs and spaces
  syn match   gdscriptSpaceError	display " \+\t"
  syn match   gdscriptSpaceError	display "\t\+ "
"endif

" Sync at the beginning of class, function, or method definition.
syn sync match gdscriptSync grouphere NONE "^\s*\%(master\|slave\|sync\|remote\|func\|class\)\s\+\h\w*\s*("

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
  "if exists("gdscript_space_error_highlight")
    HiLink gdscriptSpaceError	Error
  "endif

  delcommand HiLink
endif

let b:current_syntax = "gdscript"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set sw=2 sts=2 ts=8 noet:
