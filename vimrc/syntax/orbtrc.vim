" Copyright (c) 2025 IBM Corporation and others.
" All rights reserved. This program and the accompanying materials
" are made available under the terms of the Eclipse Public License 2.0
" which accompanies this distribution, and is available at
" http://www.eclipse.org/legal/epl-2.0/
"
" SPDX-License-Identifier: EPL-2.0
"
" Contributors:
"     IBM Corporation - initial API and implementation


" Vim syntax file
" Language:	IBM ORB trace
" Filenames:    ot*
"



" Start by clearing out any old definitions
syntax clear

" Ignore case differences
syn case ignore

" Define the standard orb trace line
" timestamp class method:line thread component text 
syn match otTimestamp	/^[0-9:.]\{12,}/	 					nextgroup=otClass	skipwhite
syn match otClass	/[^ ]\+/		contains=otLine		contained	nextgroup=otMethod	skipwhite
syn match otMethod	/\v[^ ]+( \([^\(\)]*\)[:0-9]+| _invoke)=/	contained	nextgroup=otThread	skipwhite
syn match otThread	/[^ ]\+/					contained	nextgroup=otComponent	skipwhite
syn match otComponent	/[^ ]\+/					contained	nextgroup=otText 	skipwhite
syn match otText	/.*/			contains=otHexData	contained

" and try to capture any continuation lines
syn match otTextCont	/\v^([0-9:.]{12,})@!.*/	  contains=otDirection,otMsgType,otMsgAttr,otHexIndex,otHexData,otStack

" define parts of comm trace
syn match otDirection	/\v(IN COMING|OUT GOING):/			contained
syn match otMsgType	/^.* Message$/					contained
syn match otMsgAttr	/\v(Date|Thread Info|(Local|Remote) (Port|IP)|GIOP Version|Byte order|Message size|Request ID|Reply Status|Data Offset|Object Key|Operation|Fragment to follow|Response Flag|Service Context|Target Address):/ contained
syn match otHexIndex	/^[0-9A-F]\{4}:/				contained
syn match otHexData	/\v [0-9A-F][0-9A-F ]{7} ([0-9A-F ]{8} ){3}/	contained contains=otValueTag,otPadding
syn match otValueTag	/\v7FFFFF[0-9A-F]{2}/
syn match otPadding     /\v(BD)+ /
syn match otPadding	/\v( ..)@<=BD/

" define the 'incidental' hex data that may appear all over the place
syn match otHexData	/0x[0-9A-F]\+/					contained
syn match otHexData	/\v(IOR:)@<=[0-9A-F]{10,}/			contained
syn match otHexData	/\v(\@)@<=[0-9A-F]{4,}/				contained
syn match otHexData	/\v(\=)@<=[0-9A-F]{10,}([[:alnum:]])@!/		contained




" treat stack trace lines specially
syn match otStack	/^[[:blank:]]*at .*(.*)$/			


" indicate how to highlight each bit of orb trace
highlight link otTimestamp	Label
highlight link otClass		Type
highlight link otMethod		Identifier
highlight link otLine		Label
highlight link otThread		Macro
highlight link otComponent	Ignore
highlight link otText		Comment
highlight link otTextCont	Comment

highlight link otDirection	Underlined
highlight link otMsgType	Type
highlight link otMsgAttr	Identifier
highlight link otHexIndex	Label
highlight link otHexData	Number
highlight link otHexAscii	Comment
highlight link otValueTag	Underlined
highlight link otPadding	Ignore

highlight link otStack		Error



