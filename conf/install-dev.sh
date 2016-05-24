#!/bin/bash
#
# Devlopment tools installation script, for fresh Ubuntu box
#
# Note: git should be installed at this point
#

mkdir -p $HOME/bin
mkdir -p $HOME/apps
mkdir -p $HOME/temp

#
# Core
#
sudo apt-get -y install vim emacs gcc g++ cmake curl libcurl4-gnutls-dev libxml2-dev libssl-dev unzip m4 aspcud rsync darcs mercurial pkg-config octave mc pkg-config clang

#
# Java tools
#
sudo apt-add-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get -y install oracle-java8-installer ant

# scala
# TODO: post install script
mkdir -p $HOME/apps/scala
wget http://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.tgz $HOME/apps/scala/
pushd $HOME/apps/scala/
tar xzf scala-2.11.8.tgz
# rm scala-2.11.8.tgz
popd

# clojure
#TODO

#
# Julia
#
# TODO: install main packages
#
mkdir -p  $HOME/apps/Julia
pushd $HOME/apps/Julia
wget https://julialang.s3.amazonaws.com/bin/linux/x64/0.4/julia-0.4.5-linux-x86_64.tar.gz
tar xzf julia-0.4.5-linux-x86_64.tar.gz
rm -f julia
ln -s julia-0.4.5 julia
rm julia-0.4.5-linux-x86_64.tar.gz
popd

echo 'export JULIA_HOME=$HOME/apps/Julia/julia/bin' >> $HOME/.bashrc

#
# Mono + Fsharp
#
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
sudo apt-get update
sudo apt-get -y install mono-complete fsharp referenceassemblies-pcl ca-certificates-mono mono-xsp4

#
# R install
#
sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list'
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -

sudo apt-get update
sudo apt-get -y install r-base

#
# Elixir
#
# TODO: install phoenix
#
pushd $HOME/temp
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb
sudo apt-get update
sudo apt-get -y install esl-erlang
sudo apt-get -y install elixir
# rm erlang-solutions_1.0_all.deb
popd

#
# Ocaml
#
wget https://raw.github.com/ocaml/opam/master/shell/opam_installer.sh -O - | sh -s /usr/local/bin
opam conf -a env
opam init
opam install batteries lwt core ocamlnet eliom camomile camlimages bitstring oscigenserver utf async flambda ulex cohttp menhir piqi parmap utop tyxml

#
# Rust
#
curl -sSf https://static.rust-lang.org/rustup.sh | sh

#
# Cassandra node
#  
# Note: shouldn't be here
# cassandra

#
# Cocos2d-x
#
# TODO
# - Android SDK 
# - Android NDK
# - Ant
# - cocos2x
pushd $HOME/temp
wget -q https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz &
wget -q http://dl.google.com/android/repository/android-ndk-r11c-linux-x86_64.zip &
wget -q http://cocos2d-x.org/filedown/cocos2d-x-3.11.zip &

wait

mkdir -p $HOME/apps/Android/SDK $HOME/apps/Android/NDK $HOME/apps/cocos2dx
tar xzf android-sdk_r24.4.1-linux.tgz -C $HOME/apps/Android/SDK
unzip android-ndk-r11c-linux-x86_64.zip -d $HOME/apps/Android/NDK

echo 'export ANDROID_SDK_ROOT=$HOME/apps/Android/SDK/android-sdk-linux' >> $HOME/.bashrc
echo 'export NDK_ROOT=$HOME/apps/Android/NDK' >> $HOME/.bashrc

source $HOME/.bashrc

unzip cocos2d-x-3.11.zip -d $HOME/apps/cocos2dx
# TODO: run install script

# rm -f android-sdk_r24.4.1-linux.tgz
# rm -f android-ndk-r11c-linux-x86_64.zip 
# rm -f cocos2d-x-3.11.zip
popd 

#
# Update PATH variable
# 
echo 'export PATH=$JULIA_HOME:$HOME/bin:$PATH' >> $HOME/.bashrc

source $HOME/.bashrc

