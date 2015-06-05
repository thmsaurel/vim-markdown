" description
" " TITLE "
"
" File Name         : markdown.vim
" Created By        : Thomas Aurel
" Creation Date     : January  7th, 2015
" Version           : 0.1
" Last Change       : February 16th, 2015 at 14:14:49
" Last Changed By   : Thomas Aurel
"
if exists("b:current_syntax")
    finish
endif

syntax case ignore

" ======================
"   CLUSTER DEFINITION
" ======================
" main clusters
syntax cluster markdownInline contains=@markdownEmphasis,@markdownLink,@markdownFile,@markdownMisc
syntax cluster markdownBlock contains=markdownBlockquote,@markdownList,markdownTitle,markdownCodeBlock

" secondary clusters
syntax cluster markdownEmphasis contains=markdownItalic,markdownStrong,markdownItalicStrong
syntax cluster markdownList contains=markdownClassicList,markdownOrderedList
syntax cluster markdownLink contains=markdownLinkTitle,markdownURL
syntax cluster markdownFile contains=markdownImageLink,markdownFileLink
syntax cluster markdownMisc contains=markdownNumber,markdownDelimiter,markdownAccent,markdownError,markdownCodeLine,markdownEmail,markdownSpecial
syntax cluster markdownCode contains=markdownCodeBlock,markdownCodeLine

" =====================
"   SYNTAX DEFINITION
" =====================
" --------
"   Line
" --------
syntax match markdownLine "\v^.*$" contains=@markdownInline,@markdownBlock

" ----------
"   titles
" ----------
syntax match markdownTitle "\v#{1,6}\s.*" contains=@markdownInline contained
syntax match markdownTitle "\v^.*\n\=+$" contained contains=@markdownEmphasis
syntax match markdownTitle "\v^.*\n-+$" contained contains=@markdownEmphasis

" ---------------
"   blockquotes
" ---------------
syntax match markdownBlockquote "\v^\>.*$" contains=@markdownInline,markdownTitle,@markdownCode,@markdownList contained

" ------------------------
"   Italic, Strong and Both
" ------------------------
syntax match markdownItalic "\v%(\s|^|['"\(])@<=(\*[0-9A-Za-z\-_#\$/`,\.\(\) \<\>\+=]+\*|_[0-9A-Za-z\-\*#\$/`\.,\(\) \<\>\+=]+_)%(\s|$|[,\.\<:\(\)'"])@=" contained contains=markdownCodeLine
syntax match markdownStrong "\v%(\s|^|['"\(])@<=(\*{2}[0-9A-Za-z\-_#\$/`,\.\(\) \<\>\+=]+\*{2}|_{2}[0-9A-Za-z\-\*#\$/`,\.\(\) \<\>\+=]+_{2})%(\s|$|[,\.\<:\(\)'"])@=" contained contains=markdownCodeLine
syntax match markdownItalicStrong "\v%(\s|^|['"\(\)])@<=(\*{3}[0-9A-Za-z\-,_#\$/`\.\(\) \<\>\+=]+\*{3}|_{3}[0-9A-Za-z\-\*,#\$/`\.\(\) \<\>\+=]+_{3})%(\s|$|[,\.\<:\(\)'"])@=" contained contains=markdownCodeLine

" ---------
"   Lists
" ---------
syntax match markdownClassicList "\v\s*[\*\+-]\s+.*$" contains=@markdownInline contained
syntax match markdownOrderedList "\v\s*\d+\.\s+.*$" contains=@markdownInline contained

" ---------
"   Links
" ---------
syntax region markdownFileLink start="\v\[\[\S" end="\v\S\]\]" contained oneline
syntax region markdownImageLink start="\v!\[\S" end="\v\S\]" contained oneline

syntax region markdownLinkTitle start="\v%(\[)@<=\S" end="\v\S%(\])@=" contained oneline nextgroup=markdownURL
syntax match markdownURLTitle "\v\"\S.*\S\S\"" contained
syntax region markdownURL start="\v%(\]\()@<=\S" end="\v\S%(\)$|\)\s|\):|\),|\)\.)@=" oneline contained contains=markdownURLTitle
"
" url match
" syntax match markdownURLLine "\%(^\|\s\|(\|\[\)\@<=\w+://\w[0-9A-Za-Z\.-]+\w\(/\|\)\%(\s\|$\|)\|\]\)\@=" contained
" syntax match markdownURLLine "\%(^\|\s\|(\|\[\)\@<=\w[0-9A-Za-Z\.-]+\w\(/\|\)\%(\s\|$\|)\|\]\)\@=" contained

" email address
syntax match markdownEmail "\v%(\s|^)@<=[0-9A-Za-z\._-]+\@[0-9A-Za-z\._-]+%(\s|$)@=" contained

" code
syntax match markdownCodeLine "\v%(^|\s|\(|/|\*)@<=`{1,3}[0-9A-Za-z-_~#\$\//\.\*\(\) \<\>\+=]*`{1,3}%(\s|$|[,'"]|\.|/|:|\)|\*)@=" contained
syntax region markdownCodeBlock start=/\v^[`\~]{3}\w*$/ end=/\v^[`\~]{3}$/
syntax region markdownCodeBlock start=/\v^\>\s[`\~]{3}\w*$/ end=/\v^\>\s[`\~]{3}$/

" =================
"   Miscellaneous
" =================
" number
syntax match markdownNumber "\v\d+" contained
syntax match markdownNumber "\v\d+[\.,]\d+" contained
" warning
syntax match markdownSpecial "\v/!\\" contained

syntax match markdownAccent "\v\&[A-Za-Z]+;" contained
syntax match markdownDelimiter "\v\<br\>" contained

" =========
"   Error
" =========
syntax match markdownError "\v^.*\s+$" contained
syntax match markdownError "\v%(\[|\s)@!\.{3}%(\s|$|\"|\])@!" contained
syntax match markdownError "\v%(\s|\w|\.|\[)@<!\.%(\.|]|\"|s|\$)<@!" contained
syntax match markdownError "\v%(\S)@<![,!]" contained
syntax match markdownError "\%(\S\|?\|\)\@=!\%($\|?\|\s\)\@<!" contained
syntax match markdownError ",\%(\s\|$\)\@!" contained
syntax match markdownError "\%(\s\)\@<![:;]\%(\s\|$\|<\)\@!" contained

" code block error
syntax match markdownError "\v%(^|^\>\s)@<![`\~]{1,3}%($)@=" contained
syntax match markdownError "\v`{4,}" contained

" emphasis error
syntax match markdownError "\v%(\s|^|['"\(])@<![_\*]{1,3}.*[_\*]{1,3}%(\s|$|[,\.\<:\(\)'"])@!" contained
syntax match markdownError "\v%(\s|^|['"\(])@<![_\*]{1,3}.*[_\*]{1,3}%(\s|$|[,\.\<:\(\)'"])@!" contained

" syntax match markdownError "\v%(\s|^|['"])@<!\*{1,3}(\s[0-9A-Za-z\-_#\$/`\.\(\) \<\>\+=]*|[0-9A-Za-z\-_#\$/`\.\(\) \<\>\+=]*\s)\*{1,3}%(\s|$|[,\.\<:\(\)'"])@!" contained
" code line error
syntax match markdownError "\v%(^|\s|\(|/|\*)@<=`[0-9A-Za-z-_#\$/\.\(\) \<\>\+=]*`{2,3}%(\s|$|,|\.|/|:|\)|\*)@=" contained
syntax match markdownError "\v%(^|\s|\(|/|\*)@<=`{2}[0-9A-Za-z-_#\$/\.\(\) \<\>\+=]*(`|`{3})%(\s|$|,|\.|/|:|\)|\*)@=" contained
syntax match markdownError "\v%(^|\s|\(|/|\*)@<=`{3}[0-9A-Za-z-_#\$/\.\(\) \<\>\+=]*`{1,2}%(\s|$|,|\.|/|:|\)|\*)@=" contained
syntax match markdownError "\v%(^|\s|\(|/|\*)@<!`{1,3}[0-9A-Za-z-_#\$/\.\(\) \<\>\+=]*`{1,3}%(\s|$|,|\.|/|:|\)|\*)@=" contained

" ==================
"   Highlight Name
" ==================
highlight link markdownTitle MarkdownTitle
highlight link markdownBlockquote MardownBlockquote

highlight link markdownStrong MarkdownStrong
highlight link markdownItalic MarkdownItalic
highlight link markdownItalicStrong MarkdownItalicStrong

highlight link markdownOrderedList MarkdownList
highlight link markdownClassicList MarkdownList

highlight link markdownFileLink MarkdownFile
highlight link markdownImageLink MarkdownFile

highlight link markdownLinkTitle MarkdownLinkTitle
highlight link markdownURL MarkdownURL
highlight link markdownURLLine MarkdownURL
highlight link markdownURLTitle MarkdownURLTitle
highlight link markdownEmail MarkdownEmail

highlight link markdownCodeBlock MarkdownCode
highlight link markdownCodeLine MarkdownCode

highlight link markdownAccent MarkdownAccent
highlight link markdownDelimiter Delimiter
highlight link markdownError Error

highlight link markdownNumber Number
highlight link markdownSpecial Special

let b:current_syntax = "markdown"
