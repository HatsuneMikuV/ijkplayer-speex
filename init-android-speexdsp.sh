#! /usr/bin/env bash
#
# Copyright (C) 2013-2015 Zhang Rui <bbcallen@gmail.com>
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

IJK_SPEEXDSP_UPSTREAM=https://github.com/xiph/speexdsp.git
IJK_SPEEXDSP_FORK=https://github.com/HatsuneMikuV/speexdsp.git
IJK_SPEEXDSP_COMMIT=SpeexDSP-1.2rc3
IJK_SPEEXDSP_LOCAL_REPO=extraSpeex/speexdsp

set -e
TOOLS=tools

echo "== pull speexdsp base =="
sh $TOOLS/pull-repo-base.sh $IJK_SPEEXDSP_UPSTREAM $IJK_SPEEXDSP_LOCAL_REPO

function pull_fork()
{
    echo "== pull speexdsp fork $1 =="
    sh $TOOLS/pull-repo-ref.sh $IJK_SPEEXDSP_FORK android/contrib/speexdsp-$1 ${IJK_SPEEXDSP_LOCAL_REPO}
    cd android/contrib/speexdsp-$1
    git checkout ${IJK_SPEEXDSP_COMMIT} -B ijkplayer
    ./autogen.sh
    cd -
}

pull_fork "armv5"
pull_fork "armv7a"
pull_fork "arm64"
pull_fork "x86"
pull_fork "x86_64"
