#! /usr/bin/env bash
#
# Copyright (C) 2013-2014 Zhang Rui <bbcallen@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#----------
# modify for your build tool

FF_ALL_SH="ogg speex speexdsp openssl ffmpeg"

#----------
UNI_BUILD_ROOT=`pwd`
UNI_TMP="$UNI_BUILD_ROOT/tmp"
UNI_TMP_LLVM_VER_FILE="$UNI_TMP/llvm.ver.txt"
FF_TARGET=$1
set -e

#----------
if [ "$FF_TARGET" = "all" ]; then
    for FF_SH in $FF_ALL_SH
    do
        sh "compile-$FF_SH.sh" all
    done

elif [ "$FF_TARGET" = "clean" ]; then
    for FF_SH in $FF_ALL_SH
    do
        sh "compile-$FF_SH.sh" clean
    done
else
    echo "Usage:"
    echo "  compile-all.sh all"
    echo "  compile-all.sh clean"
    exit 1
fi
