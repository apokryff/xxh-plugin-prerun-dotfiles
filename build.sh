#!/usr/bin/env bash

CDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
build_dir=$CDIR/build

while getopts A:K:q option
do
  case "${option}"
  in
    q) QUIET=1;;
    A) ARCH=${OPTARG};;
    K) KERNEL=${OPTARG};;
  esac
done

cd "$CDIR"
rm -rf $build_dir && mkdir -p $build_dir

# Download dotfiles
git clone "https://github.com/apokryff/dotfiles.git" "$build_dir/home/dotfiles"

# Download neovim config
git clone "https://github.com/apokryff/nvim.git" "$build_dir/home/.config/nvim"


for f in *prerun.sh home pluginrc.zsh
do
    cp -R "$CDIR/$f" "$build_dir/"
done

# if [ -x "$(command -v pip)" ]; then
#
#   PYTHONUSERBASE=$build_dir/home/.local pip install --user -I -r pip-requirements.txt
#
#   # Fix python shebang
#   pypath=`readlink -f $(which python)`
#   if [ -d "$build_dir/home/.local/bin" ]; then
#     echo 'Fix PyPi packages shebang'
#     sed -i '1s|#!'$pypath'|#!/usr/bin/env python|' $build_dir/home/.local/bin/*
#   fi
#
# else
#   echo 'Skip pip packages installation: pip not found.'
# fi
