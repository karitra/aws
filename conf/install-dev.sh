#!/bin/bash
#
# Devlopment tools installation script, for fresh Ubuntu box
#
# Note: git should be installed at this point
#

mkdir -p $HOME/bin
mkdir -p $HOME/apps
mkdir -p $HOME/temp
mkdir -p $HOME/data/kaggle.com
mkdir -p $HOME/prj/aws
mkdir -p $HOME/prj/study

pushd $HOME/bin
wget -q https://dist.nuget.org/win-x86-commandline/v3.4.3/nuget.exe 
popd

cd $HOME/prj/aws

#
# Core
#
sudo apt-get -y install vim emacs gcc g++ cmake curl libcurl4-gnutls-dev libxml2-dev libssl-dev unzip m4 aspcud rsync darcs mercurial pkg-config octave mc pkg-config clang htop dstat tcpdump wireshark linux-tools-generic linux-cloud-tools-generic imagemagick libgdbm-dev libgdbm3 libsqlite3-dev x11-dev screen tmux lynx libatlas-dev libatlas-base-dev
sudo apt-get -y install  libgtksourceview2.0-0 libgtksourceview2.0-common libgtksourceview2.0-dev

#
# Java tools
#
sudo apt-add-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get -y install oracle-java8-installer ant

# scala
# TODO: post install script
mkdir -p $HOME/apps/scala
pushd $HOME/apps/scala/
wget http://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.tgz 
tar xzf scala-2.11.8.tgz
rm scala-2.11.8.tgz
popd

echo 'export PATH=$HOME/apps/scala/scala-2.11.8/bin:$PATH' >> ~/.bashrc 

#
# Maven adn sbt
#
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
sudo apt-get update
sudo apt-get -y install sbt maven

# clojure
#TODO

#
# Julia
#
# TODO: install main/useful packages
#
mkdir -p  $HOME/apps/Julia
pushd $HOME/apps/Julia
wget https://julialang.s3.amazonaws.com/bin/linux/x64/0.4/julia-0.4.5-linux-x86_64.tar.gz
tar xzf julia-0.4.5-linux-x86_64.tar.gz
rm -f julia
ln -s julia-2ac304dfba julia
rm julia-0.4.5-linux-x86_64.tar.gz
popd

echo 'export JULIA_HOME=$HOME/apps/Julia/julia/bin' >> $HOME/.bashrc
$HOME/apps/Julia/julia/bin/julia -e 'Pkg.update(); Pkg.add("DataFrames"); Pkg.add("DistributedArrays"); Pkg.add("Gadfly"); Pkg.add("Images"); Pkg.add("JLD"); Pkg.add("Winston"); Pkg.add("Vega")'

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

sudo apt-get -y autoremove

#
# Ocaml
#
wget https://raw.github.com/ocaml/opam/master/shell/opam_installer.sh -O - | sh -s /usr/local/bin
opam conf -a env
opam init
opam install batteries lwt core core_bench core_extended ocamlnet eliom camomile camlimages bitstring ocsigenserver async ulex cohttp menhir piqi parmap utop tyxml merlin camlpdf re2 lablgtk lablgtk-extras lacaml ounit kaputt ctypes ctypes-foreign
sudo apt-get -y install tuareg-mode

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
echo Installing Cocos2d and andorid tools

pushd $HOME/temp
wget -q https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz &
wget -q http://dl.google.com/android/repository/android-ndk-r11c-linux-x86_64.zip &
wget -q http://cdn.cocos2d-x.org/cocos2d-x-3.11.zip &

echo Waiting for download completion
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
echo 'export LESS="-X"' >> $HOME/.bashrc


source $HOME/.bashrc

