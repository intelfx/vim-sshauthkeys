" Vim syntax file
" Language:	OpenSSH authorized keys file (authorized_keys)
" Author:	Ivan Shapovalov <intelfx@intelfx.name>
" Maintainer:	Ivan Shapovalov <intelfx@intelfx.name>
" Contributor:	Chris Weyl <cweyl@alumni.drew.edu>
" Contributor:	Mikael Svantesson <mikael@distopic.net>
" Last Change:	2026 Feb 22
" SSH Version:	10.2p1
"

if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

set iskeyword+=@-@,-,.
syn iskeyword @,48-57,@-@,-,.

" proper comment character
setlocal commentstring=#%s

" don't wrap on editing
setlocal textwidth=0

" Errors (generic) (must be the first rule)
syn match   sshError           /\S\+/                       skipwhite nextgroup=sshOption,sshSSH2KeyType,sshSSH2Key

" Options
syn match   sshOptionError     /\k\+/                       contained           nextgroup=sshOptionSep,sshOptionEnd
syn match   sshOptionSep       /,/                          contained           nextgroup=sshOption,sshOptionError
syn region  sshOptionString    start=/"/ skip=/\\"/ end=/"/ contained oneline   nextgroup=sshOptionSep,sshOptionEnd
syn match   sshOptionEnd       /\s\+/                       contained skipwhite nextgroup=sshSSH2KeyType

" Options without values
syn keyword sshOption          restrict cert-authority
                             \ agent-forwarding no-agent-forwarding
                             \ port-forwarding no-port-forwarding
                             \ X11-forwarding no-X11-forwarding
                             \ pty no-pty
                             \ user-rc no-user-rc
                             \ verify-required no-touch-required
                                                          \ contained           nextgroup=sshOptionSep,sshOptionEnd

" Options with values
syn match   sshOption          /\<\(from\|command\|environment\|expiry-time\|from\|permitlisten\|permitopen\|principals\|tunnel\)=/
                                                          \ contained           nextgroup=sshOptionString

" SSH2
"

syn keyword sshSSH2KeyType     ssh-rsa ssh-dss
                             \ ecdsa-sha2-nistp256 sk-ecdsa-sha2-nistp256@openssh.com
                             \ ecdsa-sha2-nistp384
                             \ ecdsa-sha2-nistp521
                             \ ssh-ed25519 sk-ssh-ed25519@openssh.com
                                                          \ contained skipwhite nextgroup=sshSSH2Key

syn match   sshSSH2Key         /\<AAAA[A-Za-z0-9+/=]\+/     contained skipwhite nextgroup=sshSSH2KeyEnd conceal cchar=*
syn match   sshSSH2KeyEnd      /\s\+/                       contained skipwhite nextgroup=sshSSH2Comment
syn match   sshSSH2Comment     /\S.*$/                      contained

" SSH1 (legacy)
"
syn match   sshSSH1Bits        /\d\+/                       contained skipwhite nextgroup=sshSSH1Exponent
syn match   sshSSH1Exponent    /\d\+/                       contained skipwhite nextgroup=sshSSH1Modulus
syn match   sshSSH1Modulus     /\d\+/                       contained skipwhite nextgroup=sshSSH1Comment conceal cchar=*
syn match   sshSSH1Comment     /\S.*$/                      contained

" Content lines (must be next-to-last rule)
syn match   sshLine            /^\s*/                                           nextgroup=sshSSH1Bits,sshSSH2KeyType,sshOption,sshOptionError
" Comment lines (must be the last rule as it needs to have priority over sshLine)
syn match   sshComment         /^\s*#.*/

if version >= 508
	command -nargs=+ HiLink hi link <args>
else
	command -nargs=+ HiLink hi def link <args>
endif

HiLink sshSSH1Bits      Type
HiLink sshSSH1Exponent  Special
HiLink sshSSH1Modulus   Constant
HiLink sshSSH1Comment   Comment

HiLink sshSSH2KeyType   Type
HiLink sshSSH2Comment   Comment
HiLink sshSSH2Key       Constant

HiLink sshComment       Comment
HiLink sshError         Error

HiLink sshOption        Keyword
HiLink sshOptionError   Error
HiLink sshOptionString  String

delcommand HiLink

let b:current_syntax = "sshauthkeys"
