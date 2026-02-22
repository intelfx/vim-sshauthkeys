" Vim ftdetect file
" Language:	OpenSSH authorized keys file (authorized_keys)
" Author:	Ivan Shapovalov <intelfx@intelfx.name>
" Maintainer:	Ivan Shapovalov <intelfx@intelfx.name>
" Contributor:  Chris Weyl <cweyl@alumni.drew.edu>
" Contributor:  Mikael Svantesson <mikael@distopic.net>
" Last Change:	2026 Feb 22
" SSH Version:	10.2p1
"

au BufRead,BufNewFile authorized_keys           set filetype=sshauthkeys
au BufRead,BufNewFile authorized_keys2          set filetype=sshauthkeys
au BufRead,BufNewFile authorized_keys.*         set filetype=sshauthkeys
au BufRead,BufNewFile etc/ssh/authorized_keys/* set filetype=sshauthkeys
au BufRead,BufNewFile .ssh/*.pub                set filetype=sshauthkeys
au BufRead,BufNewFile ssh/*.pub                 set filetype=sshauthkeys
