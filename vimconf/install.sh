#!/bin/bash

if [ $# -ne 2 ]; then
    echo "USAGE:"
    echo "example: ./install.sh wangjia wangjia@mitegral.com"
    exit -1
fi

user_name=$1
user_email=$2
is_net=1

dir=`dirname $0`
echo $dir
cd $dir
dir=`pwd`
echo $dir

function download_plugin()
{
    echo $1
    cur_path=`pwd`
    install_dir='vim/bundle'
    if [ ! -e $install_dir ]; then
        mkdir -p $install_dir;
    fi
    cd $install_dir
        
    for l in `cat $cur_path/$1`; do
        name=`basename $l`
        echo install $name
        git clone $l 
        echo $l
    done
    cd -
}



function main
{
    ls ~/.vimrc > /dev/null
    if (($? == 0)); then
        echo "~/.vimrc --> ~/vimrc.bak"
        sleep 0.5
        mv ~/.vimrc ~/vimrc.bak
    fi
    ls ~/.vim > /dev/null
    if (($? == 0)); then
        echo "~/.vim --> ~/vim.bak"
        sleep 0.5
        mv ~/.vim ~/vim.bak
    fi
    ln -s $dir/vimrc ~/.vimrc
    ln -s $dir/vim  ~/.vim

    sed -i "s/let g:user_name.*/let g:user_name = '$user_name'/g"  $dir/vimrc
    sed -i "s/let g:user_email.*/let g:user_email = '$user_email'/g"  $dir/vimrc
}

download_plugin plugin_list.txt
