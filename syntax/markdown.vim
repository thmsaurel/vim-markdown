" description
" " TITLE "
"
" File Name         : markdown.vim
" Created By        : Thomas Aurel
" Creation Date     : January  7th, 2015
" Version           : 0.1
" Last Change       : February  6th, 2015 at 10:42:58
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
syntax cluster markdownInline contains=@markdownEmphasis,@markdownLink,markdownError,markdownCodeLine,markdownDelimiter,markdownEmail,markdownAccent,@markdownFile
syntax cluster markdownBlock contains=markdownBlockquote,@markdownList,markdownTitle

" secondary clusters
syntax cluster markdownEmphasis contains=markdownItalic,markdownStrong,markdownItalicStrong
syntax cluster markdownList contains=markdownClassicList,markdownOrderedList
syntax cluster markdownLink contains=markdownLinkTitle,markdownURL
syntax cluster markdownFile contains=markdownImageLink,markdownFileLink

" =====================
"   SYNTAX DEFINITION
" =====================
" --------
"   Line
" --------
syntax match markdownLine "\v.*$" contains=@markdownInline,@markdownBlock

" ----------
"   titles
" ----------
syntax match markdownTitle "\v#{1,6}\s.*" contains=@markdownInline contained
syntax match markdownTitle "\v^.*\n\=+$" contained contains=@markdownEmphasis
syntax match markdownTitle "\v^.*\n-+$" contained contains=@markdownEmphasis

" ---------------
"   blockquotes
" ---------------
syntax match markdownBlockquote "\v^\>.*$" contains=@markdownInline,markdownTitle contained

" ------------------------
"   Italic, Strong and Both
" ------------------------
syntax region markdownItalic start="\%(\s\|^\|['"]\)\@<=\*\%(\s\|$\)\@!" end="\%(\s\|$\)\@<!\*\%(\s\|\|$\|[,\.<:)'"]\)\@=" contained oneline
syntax region markdownItalic start="\%(\s\|^\|['"]\)\@<=_\%(\s\|$\)\@!" end="\%(\s\|$\)\@<!_\%(\s\|\|$\|[,\.<:)'"]\)\@=" contained oneline
syntax region markdownStrong start="\%(\s\|^\|['"]\)\@<=\*\*\%(\s\|$\)\@!" end="\%(\s\|$\)\@<!\*\*\%(\s\|$\|[,\.<:)'"]\)\@=" contained oneline
syntax region markdownStrong start="\%(\s\|^\|['"]\)\@<=__\%(\s\|$\)\@!" end="\%(\s\|$\)\@<!__\%(\s\|$\|[,\.<:)'"]\)\@=" contained oneline
syntax region markdownItalicStrong start="\%(\s\|^\|['"]\)\@<=\*\*\*\%(\s\|$\)\@!" end="\%(\s\|$\)\@<!\*\*\*\%(\s\|$\|[,\.<:)'"]\)\@=" contained oneline
syntax region markdownItalicStrong start="\%(\s\|^\|['"]\)\@<=___\%(\s\|$\)\@!" end="\%(\s\|$\)\@<!___\%(\s\|$\|[,\.<:)'"]\)\@=" contained oneline

" ---------
"   Lists
" ---------
syntax match markdownClassicList "\v^\s*[\*\+-]\s+.*$" contains=@markdownInline contained
syntax match markdownOrderedList "\v^\s*\d+\.\s+.*$" contains=@markdownInline contained

" ---------
"   Links
" ---------
syntax region markdownFileLink start="\[\[\S" end="\S\]\]" contained oneline
syntax region markdownImageLink start="!\[\S" end="\S\]" contained oneline

syntax region markdownLinkTitle start="\%(\[\)\@<=\S" end="\S\%(\]\)\@=" contained oneline nextgroup=markdownURL
syntax match markdownURLTitle "\v\"\S.*\S\S\"" contained
syntax region markdownURL start="\%(\](\)\@<=\S" end="\S\%()$\|)\s\|):\|),\|)\.\)\@=" oneline contained contains=markdownURLTitle
"
" url match
" syntax match markdownURLLine "\%(^\|\s\|(\|\[\)\@<=\w+://\w[0-9A-Za-Z\.-]+\w\(/\|\)\%(\s\|$\|)\|\]\)\@=" contained
" syntax match markdownURLLine "\%(^\|\s\|(\|\[\)\@<=\w[0-9A-Za-Z\.-]+\w\(/\|\)\%(\s\|$\|)\|\]\)\@=" contained

" email address
syntax match markdownEmail "\%(\s\|^\)\@<=[0-9A-Za-z\._-]+@[0-9A-Za-z\._-]+\%(\s\|$\)\@=" contained

" code
syntax match markdownCodeLine "\s```\S.*\S```\(\s\|$\|,\|\.\|(\)\@=" contained
syntax region markdownCode start=/\v^```.*/ end=/\v```$/
syntax region markdownCode start=/\v^\~\~\~.*/ end=/\v\~\~\~$/

syntax match markdownAccent "\v\&[A-Za-Z]+;" contained
syntax match markdownDelimiter "\v\<br\>" contained
" =========
"   Error
" =========
syntax match markdownError "\v.*\s+$" contained
syntax match markdownError "\%(\S\)\@<![\.,?!]" contained
syntax match markdownError "\.\%(\.\|)\|\s\|$\)\@!" contained
syntax match markdownError ",\%(\s\|$\)\@!" contained
syntax match markdownError "\%(\s\)\@<![:;]\%(\s\|$\)\@!" contained

" ==================
"   Highlight Name
" ==================
highlight link markdownTitle MarkdownTitle
highlight link markdownBlockquote MardownBlockquote

highlight link markdownStrong MarkdownStrong
highlight link markdownItalic MarkdownItalic
highlight link markdownItalicStrong MarkdownItalicStrong

highlight link markdownOrderedList MarkdownOrderedList
highlight link markdownClassicList MarkdownClassicList

highlight link markdownFileLink MarkdownFile
highlight link markdownImageLink MarkdownFile

highlight link markdownLinkTitle MarkdownLinkTitle
highlight link markdownURL MarkdownURL
highlight link markdownURLLine MarkdownURL
highlight link markdownURLTitle MarkdownURLTitle
highlight link markdownEmail MarkdownEmail

highlight link markdownCode MarkdownCode
highlight link markdownCodeLine MarkdownCodeLine

highlight link markdownAccent MarkdownAccent
highlight link markdownDelimiter Delimiter
highlight link markdownError Error

let b:current_syntax = "markdown"
