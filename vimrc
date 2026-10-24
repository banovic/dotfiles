" Make sure defaults.vim isn't skipped if something set this flag
unlet! skip_defaults_vim
" Load Vim's defaults, which are skipped once a vimrc exists
source $VIMRUNTIME/defaults.vim
" Save by overwriting the file in place, not by writing a new file and renaming it.
" This keeps the file's inode, so hard links and file watchers keep working.
" Needed for `crontab -e`, which rejects its temp file if it isn't edited in place.
set backupcopy=yes
