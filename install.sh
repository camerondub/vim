#!/bin/bash
# environment install script for vim config
#######################################


# resolve target deploy directory
if [ "$#" -eq 1 ]; then
    targetdir=$1
elif [ "$#" -eq 0 ]; then
    targetdir=$HOME
else
    echo "error: must pass 0 or 1 arguments"
    exit 1
fi

# resolve relative path from target to the directory this script is in
thisdir=$(python3 -c "import os.path; print(os.path.abspath('$(dirname ${BASH_SOURCE[0]})'))")
relpath=$(python3 -c "import os.path; print(os.path.relpath('${thisdir}', '${targetdir}'))")

# remove old links
rm -f ${targetdir}/.vim ${targetdir}/.vimrc

# install new links
ln -s ${relpath} ${targetdir}/.vim
ln -s ${relpath}/.vimrc ${targetdir}/.vimrc
