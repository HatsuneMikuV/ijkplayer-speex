#! /usr/bin/env bash


FF_ALL_ARCHS_CUSTOM_SDK="arm64"
#FF_ALL_ARCHS_CUSTOM_SDK="arm64 armv7s x86_64 i386 armv7"


FF_ALL_ARCHS=$FF_ALL_ARCHS_CUSTOM_SDK

FF_ALL_SH="ogg speex speexdsp openssl ffmpeg"


for FF_SH in $FF_ALL_SH
do
    sh init-ios-$FF_SH.sh $FF_ALL_ARCHS
done



cd ios

for FF_SH in $FF_ALL_SH
do
    for ARCH in $FF_ALL_ARCHS
    do
    sh compile-$FF_SH.sh $ARCH
    done
done





