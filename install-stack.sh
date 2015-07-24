#!/usr/bin/env bash

msg() { echo "--- $@" 1>&2; }
detail() { echo "	$@" 1>&2; }
verlte() {
  [ "$1" = `echo -e "$1\n$2" | sort -t '.' -k 1,1n -k 2,2n -k 3,3n -k 4,4n | head -n1` ]
}


for i in ctags git make vim curl-config stack; do
  command -v $i >/dev/null
  if [ $? -ne 0 ] ; then
    msg "Installer requires ${i}. Please install $i and try again."
    exit 1
  fi
done


VIM_VER=$(vim --version | sed -n 's/^.*IMproved \([^ ]*\).*$/\1/p')

GHC_VER=$(stack ghc -- --numeric-version)

if ! verlte '7.4' $VIM_VER ; then
  msg "Vim version 7.4 or later is required. Aborting."
  exit 1
fi

if ! verlte '7.6.3' $GHC_VER ; then
  msg "GHC version 7.6.3 or later is required. Aborting."
  exit 1
fi

if ! ctags --version | grep -q "Exuberant" ; then
  msg "Requires exuberant ctags, not just ctags. Aborting."
  exit 1
fi

endpath="$HOME/.haskell-vim-now"


